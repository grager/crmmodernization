package com.castsoftware.crm.customviews

import android.app.DatePickerDialog
import android.content.Context
import android.text.InputType
import android.util.AttributeSet
import android.view.View
import android.widget.EditText
import android.widget.TextView
import androidx.constraintlayout.widget.ConstraintLayout
import com.google.android.material.textfield.TextInputEditText
import com.castsoftware.crm.R
import kotlinx.android.synthetic.main.form_pair.view.*
import java.util.*

class FormPairView(context: Context, attrs: AttributeSet) : ConstraintLayout(context, attrs) {

    private val calendar = Calendar.getInstance()
    private var year = calendar.get(Calendar.YEAR)
    private var month = calendar.get(Calendar.MONTH)
    private var day = calendar.get(Calendar.DAY_OF_MONTH)

    init {

        View.inflate(context, R.layout.form_pair, this)

        val textView: TextView = findViewById(R.id.textView)
        val editTextView: TextInputEditText = findViewById(R.id.editText)

        val attributes = context.obtainStyledAttributes(attrs, R.styleable.FormPairView)
        textView.text = attributes.getText(R.styleable.FormPairView_text)
        editTextView.hint = attributes.getText(R.styleable.FormPairView_text)
        editTextView.inputType = when (attributes.getInt(R.styleable.FormPairView_type, 0)) {
            0 -> InputType.TYPE_CLASS_TEXT
            1 -> InputType.TYPE_CLASS_PHONE
            2 -> InputType.TYPE_TEXT_VARIATION_EMAIL_ADDRESS
            3 -> InputType.TYPE_DATETIME_VARIATION_DATE
            else -> InputType.TYPE_CLASS_TEXT
        }

        if (attributes.getInt(R.styleable.FormPairView_type, 0) == 3) {
            calendarIcon.visibility = View.VISIBLE
            editTextView.isEnabled = false
            calendarIcon.setOnClickListener {
                createDialog()
            }
        }

        attributes.recycle()
    }

    private val datePicker =
        DatePickerDialog.OnDateSetListener { view, year, month, dayOfMonth ->
            this.year = year
            this.month = month
            this.day = dayOfMonth

            val dateStr = "$year-${if (month+1 > 10) month+1 else "0${month+1}"}-${if(day > 10) day else "0$day" }"
            //val dateStr = "$year-${month+1}-$day"

            editText.setText(dateStr)

        }

    private fun createDialog(){
        DatePickerDialog(context,datePicker,year,month,day).show()
    }

    fun getTitle() : String{
        return textView.text.toString()
    }

    fun getText(): String {
        return editText.text.toString()
    }

    fun setError(error : String){
        editText.error = error
    }


}
