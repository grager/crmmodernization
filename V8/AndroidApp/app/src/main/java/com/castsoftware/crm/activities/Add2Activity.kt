package com.castsoftware.crm.activities

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.view.inputmethod.InputMethodManager
import android.widget.EditText
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import androidx.recyclerview.widget.LinearLayoutManager
import com.castsoftware.crm.AddContactAdapter
import com.castsoftware.crm.ApiEssentials
import com.castsoftware.crm.CrmRetrofit
import com.castsoftware.crm.R
import com.castsoftware.crm.dataclasses.contacts.AddResponse
import com.castsoftware.crm.dataclasses.crmlayouts.ContactLayouts
import com.castsoftware.crm.dataclasses.crmlayouts.PickValues
import kotlinx.android.synthetic.main.activity_add2.*
import retrofit2.Call
import retrofit2.Response
import java.io.Serializable

class Add2Activity : AppCompatActivity(), AddContactAdapter.OnPickListClicked {

    private val TAG = Add2Activity::class.java.simpleName
    private val PICK_LIST: Int = 4
    private lateinit var pickListTextView: EditText
    private val hashMap: HashMap<String, String> = HashMap()
    private var formAdapter = AddContactAdapter(this, ArrayList(), hashMap)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add2)
        setSupportActionBar(toolBar)
        toolBar.setNavigationOnClickListener { finish() }
        window.statusBarColor = ContextCompat.getColor(this, R.color.colorPrimaryDark)
        addContactForm.adapter = formAdapter
        addContactForm.layoutManager = LinearLayoutManager(this)
        addContactForm.setItemViewCacheSize(20)

        val call = CrmRetrofit.getApi().getContactLayouts(ApiEssentials.header)
        call.enqueue(object : retrofit2.Callback<ContactLayouts> {
            override fun onFailure(call: Call<ContactLayouts>, t: Throwable) {
                Log.e(TAG, ":: onFailure called! Error = $t")
            }

            override fun onResponse(
                call: Call<ContactLayouts>,
                response: Response<ContactLayouts>
            ) {

                runOnUiThread {
                    loading.visibility = View.GONE
                }

                if (response.isSuccessful) {
                    if (response.body() != null) {
                        val data = response.body() as ContactLayouts
                        val list: MutableList<Any> = ArrayList()
                        Log.e(TAG,"Response = ${response.body()}")
                        data.layouts[0].sections.forEach {
                            list.add(it.displayLabel)
                            it.fields.forEach { field ->
                                if (!field.fieldReadOnly && dataTypeChecker(field.dataType)) {
                                    list.add(field)
                                    hashMap[field.apiName] = if (field.dataType == "picklist") {
                                        field.pickListValues[0].displayValue
                                    } else {
                                        ""
                                    }
                                }
                            }
                            if (list[list.size - 1] is String) {
                                list.removeAt(list.size - 1)
                            }
                        }
                        Log.e(TAG, hashMap.toString())
                        formAdapter.setMap(hashMap)
                        formAdapter.setFields(list)
                    } else {
                        Log.e(
                            TAG,
                            "::onResponse called Body null Response = ${response.body()}"
                        )
                    }
                } else {
                    Log.e(
                        TAG,
                        "::onResponse called Success Failed Response = ${response.body()}"
                    )
                }
            }

        })

    }

    private fun hideKeyBoard() {
        val input: InputMethodManager =
            getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
        input.hideSoftInputFromWindow(parentLayout.applicationWindowToken, 0)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {
            R.id.saveContact -> {
                hideKeyBoard()
                loading.visibility = View.VISIBLE
                Log.e(TAG, formAdapter.valueMap.toString())
                val contacts: MutableList<HashMap<String, String>> = ArrayList()
                contacts.add(formAdapter.valueMap)
                val data: HashMap<String, List<HashMap<String, String>>> = HashMap()
                data["data"] = contacts
                val call = CrmRetrofit.getApi().addContact(data, ApiEssentials.header)
                call.enqueue(object : retrofit2.Callback<AddResponse> {
                    override fun onFailure(call: Call<AddResponse>, t: Throwable) {
                        Log.e(TAG, ":: onFailure called!")
                    }

                    override fun onResponse(
                        call: Call<AddResponse>,
                        response: Response<AddResponse>
                    ) {
                        if (response.isSuccessful) {
                            runOnUiThread {
                                loading.visibility = View.GONE
                            }
                            if (response.body() != null) {
                                if (((response.body() as AddResponse).data)[0].code == "SUCCESS") {
                                    Toast.makeText(
                                        this@Add2Activity,
                                        "Contact added successfully",
                                        Toast.LENGTH_SHORT
                                    ).show()
                                    finish()
                                } else {
                                    Toast.makeText(
                                        this@Add2Activity,
                                        "Contact adding failed! \n" +
                                                (response.body() as AddResponse).data[0].code,
                                        Toast.LENGTH_SHORT
                                    ).show()
                                    Log.e(TAG, "Response = ${response.body()}")
                                }
                            } else {
                                Log.e(
                                    TAG,
                                    "::onResponse called Body null Response = ${response.body()}"
                                )
                            }
                        } else {
                            Log.e(
                                TAG,
                                "::onResponse called Success Failed Response = ${response.body()}"
                            )
                        }
                    }
                })
            }
        }
        return true
    }

    private fun dataTypeChecker(type: String): Boolean {
        return type == "text" || type == "phone" || type == "picklist" || type == "date" || type == "textarea"
    }

    override fun pickListData(pickValues: List<PickValues>, id: EditText) {
        pickListTextView = id
        val intent = Intent(this, PickListActivity::class.java)
        val bundle = Bundle()
        bundle.putSerializable("data", pickValues as Serializable)
        intent.putExtra("data", bundle)
        intent.putExtra("selectedValue", id.text.toString())
        startActivityForResult(intent, PICK_LIST)
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.toolbar_menu, menu)
        return true
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        Log.e(TAG, "Request code = $requestCode Result code = $resultCode")
        if (requestCode == PICK_LIST && resultCode == Activity.RESULT_OK) {
            pickListTextView.setText(data?.getStringExtra("selectValue"))
        }
    }


}
