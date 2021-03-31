package com.castsoftware.crm.activities

import android.app.Activity
import android.app.DatePickerDialog
import android.app.Dialog
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import com.castsoftware.crm.ApiEssentials
import com.castsoftware.crm.CrmRetrofit
import com.castsoftware.crm.R
import com.castsoftware.crm.customviews.FormPairView
import com.castsoftware.crm.dataclasses.contacts.AddContact
import com.castsoftware.crm.dataclasses.contacts.AddContactWrapper
import com.castsoftware.crm.dataclasses.contacts.AddResponse
import com.castsoftware.crm.dataclasses.contacts.Data
import kotlinx.android.synthetic.main.activity_add.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.util.*
import kotlin.collections.ArrayList

class   AddActivity : AppCompatActivity() {

    companion object {
        const val DATE_PICKER_ID = 4
    }

    private val TAG = AddActivity::class.java.simpleName
    private val calendar: Calendar = Calendar.getInstance()
    private var year = calendar.get(Calendar.YEAR)
    private var month = calendar.get(Calendar.MONTH)
    private var day = calendar.get(Calendar.DAY_OF_MONTH)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add)
        setSupportActionBar(toolBar)
        window.statusBarColor = ContextCompat.getColor(this,R.color.colorPrimaryDark)
        toolBar.setNavigationOnClickListener { finish() }

    }

    override fun onCreateDialog(id: Int): Dialog? {
        when (id) {
            DATE_PICKER_ID -> {
                return DatePickerDialog(this, pickerListener, year, month, day)
            }
        }
        return null
    }

    private val pickerListener: DatePickerDialog.OnDateSetListener =
        DatePickerDialog.OnDateSetListener { _, year, month, dayOfMonth ->
            this.year = year
            this.month = month
            this.day = dayOfMonth
        }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.toolbar_menu, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {
            R.id.saveContact -> {
                if (checker()) {
                    saveContact()
                }
            }
        }
        return true
    }

    private fun saveContact() {
        val firstName = firstName.getText()
        val lastName = lastName.getText()
        val mail = email.getText()
        val dob = dob.getText()
        val mobile = mobile.getText()
        loading.visibility = View.VISIBLE
        val contacts : MutableList<AddContact> = ArrayList()
            contacts.add(AddContact(firstName, lastName, mail, mobile, dob))
        val addResponse = AddContactWrapper(contacts)
        val api = CrmRetrofit.getApi()
        Log.e(TAG,"Header = ${ApiEssentials.header["Authorization"]}")
        val addContact = api.addContact(addResponse, ApiEssentials.header)

        addContact.enqueue(object : Callback<AddResponse> {
            override fun onFailure(call: Call<AddResponse>, t: Throwable) {
                Log.e(TAG, ":: onFailure called!")
            }

            override fun onResponse(call: Call<AddResponse>, response: Response<AddResponse>) {
                if (response.isSuccessful) {
                    runOnUiThread{
                        loading.visibility = View.GONE
                    }
                    if (response.body() != null) {
                        if (((response.body() as AddResponse).data)[0].code == "SUCCESS") {
                            Toast.makeText(
                                this@AddActivity,
                                "Contact added successfully",
                                Toast.LENGTH_SHORT
                            ).show()
                            sendContact(firstName,lastName,mobile,mail,dob)
                            finish()
                        } else {
                            Toast.makeText(
                                this@AddActivity,
                                "Contact adding failed! \n" +
                                        (response.body() as AddResponse).data[0].code,
                                Toast.LENGTH_SHORT
                            ).show()
                            Log.e(TAG, "Response = ${response.body()}")
                        }
                    } else {
                        Log.e(TAG, "::onResponse called Body null Response = ${response.body()}")
                    }
                } else {
                    Log.e(TAG, "::onResponse called Success Failed Response = ${response.body()}")
                }
            }

        })

    }

    private fun sendContact(fName : String, lName : String, num : String, mail : String, dob : String){
        val intent = Intent()
        val bundle = Bundle()
        bundle.putSerializable("contact",Data(fName,lName,mail,num,dob))
        intent.putExtra("contact",bundle)
        setResult(Activity.RESULT_OK,intent)
    }

    private fun checker(): Boolean {
        val textViewIdArray =
            arrayOf(R.id.firstName, R.id.lastName, R.id.email, R.id.mobile, R.id.dob)
        var isClear = true
        textViewIdArray.forEach {
            val view: FormPairView = findViewById(it)
            if (view.getText() == "") {
                view.setError("${view.getTitle()} is not empty!")
                isClear = false
            }
        }
        return isClear
    }

}
