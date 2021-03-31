package com.castsoftware.crm.activities

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.util.AttributeSet
import android.util.Log
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import com.castsoftware.crm.*
import com.castsoftware.crm.ApiEssentials.Companion.header
import com.castsoftware.crm.dataclasses.contacts.CrmContacts
import com.castsoftware.crm.dataclasses.contacts.Data
import kotlinx.android.synthetic.main.activity_add2.*
import kotlinx.android.synthetic.main.activity_main.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class MainActivity : AppCompatActivity(), TableCreatingFunction.OnTableClicked {

    private val TAG = MainActivity::class.java.simpleName

    companion object{

        const val ADD_CONTACT : Int = 4
        var crmContacts : MutableList<Data> = ArrayList()

    }

    init {
        header["Content-Type"] = "application/json"
        header["Authorization"] = "Zoho-oauthtoken ${ApiEssentials.oauthToken}"
        CrmRetrofit.getRetrofit()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        heading.text = "Contacts"

        addContact.setOnClickListener {
            startActivityForResult(Intent(this, Add2Activity::class.java), ADD_CONTACT)
        }

    }

    override fun onResume() {
        super.onResume()
        loader.visibility = View.VISIBLE
        initApiCall()
    }

    private fun initApiCall() {
        val api: ApiInterfaces = CrmRetrofit.getApi()
        val call: Call<CrmContacts> = api.getContacts(header)

        call.enqueue(object : Callback<CrmContacts> {
            override fun onFailure(call: Call<CrmContacts>, t: Throwable) {
                Log.e(TAG, ":: onFailure Called!")
            }

            override fun onResponse(call: Call<CrmContacts>, response: Response<CrmContacts>) {
                runOnUiThread {
                    loader.visibility = View.GONE
                }
                if (response.isSuccessful) {
                    if (response.body() != null) {
                        Log.e(TAG, "onResponse called Response = ${response.body()}")
                        runOnUiThread {
                            val data = (response.body() as CrmContacts).data
                            scrollLayout.removeAllViews()
                            crmContacts = data as MutableList<Data>
                            scrollLayout.addView(
                                TableCreatingFunction(
                                    this@MainActivity,
                                    data
                                ).viewReturner()
                            )
                        }
                    }else{
                        Log.e(TAG,"::onResponse called Body null")
                    }
                }else{
                    Log.e(TAG,"::onResponse called Success Failed")
                }
            }

        })
    }

    override fun sendTable(tableData: List<Data>) {

    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        Log.e(TAG,"Request code = $requestCode && Result code = $resultCode")
        if(requestCode == ADD_CONTACT && resultCode == Activity.RESULT_OK){
            val bundle = data?.getBundleExtra("contact")
            val contact : Data = bundle?.getSerializable("contact") as Data
            Log.e(TAG,contact.firstName)
            crmContacts.add(0,contact)
            scrollLayout.removeAllViews()
            loader.visibility = View.VISIBLE
            Handler().postDelayed({
                loader.visibility = View.GONE
                scrollLayout.addView(TableCreatingFunction(this, crmContacts).viewReturner())
            },2000)
        }
    }

    


}
