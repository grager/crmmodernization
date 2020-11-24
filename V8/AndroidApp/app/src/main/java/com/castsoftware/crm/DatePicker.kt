package com.castsoftware.crm

import android.app.DatePickerDialog
import android.app.Dialog
import android.content.Context
import android.widget.EditText
import java.util.*

class DatePicker(private val context: Context, editText: EditText){

    private val calendar: Calendar = Calendar.getInstance()
    private var year = calendar.get(Calendar.YEAR)
    private var month = calendar.get(Calendar.MONTH)
    private var day = calendar.get(Calendar.DAY_OF_MONTH)

    private val datePicker =
        DatePickerDialog.OnDateSetListener { view, year, month, dayOfMonth ->
            this.year = year
            this.month = month
            this.day = dayOfMonth

            val dateStr = "$year-${if (month+1 > 10) month+1 else "0${month+1}"}-${if(day > 10) day else "0$day" }"
            editText.setText(dateStr)

        }

    fun showDialog(){
        return DatePickerDialog(context,datePicker,year,month,day).show()
    }

}