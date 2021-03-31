package com.castsoftware.crm

import android.content.Context
import android.text.Editable
import android.text.InputType
import android.text.TextWatcher
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.EditorInfo
import android.widget.EditText
import android.widget.ImageView
import android.widget.TextView
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.recyclerview.widget.RecyclerView
import com.castsoftware.crm.dataclasses.crmlayouts.Field
import com.castsoftware.crm.dataclasses.crmlayouts.PickValues

class AddContactAdapter(
    private val context: Context,
    private var fields: List<Any>,
    private var map: HashMap<String, String>
) : RecyclerView.Adapter<RecyclerView.ViewHolder>() {

    private val TAG = AddContactAdapter::class.java.simpleName
    var valueMap: HashMap<String, String> = map
    private val onPickListClicked = context as OnPickListClicked

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        return if (viewType == 4) {
            val view =
                LayoutInflater.from(context).inflate(R.layout.add_contact_heading, parent, false)
            HeadingViewHolder(view)
        } else {
            val view =
                LayoutInflater.from(context).inflate(R.layout.form_pair_layout_2, parent, false)
            ViewHolder(view)
        }
    }

    fun setMap(map: HashMap<String, String>) {
        valueMap = map
        notifyDataSetChanged()
    }

    fun setFields(fields: List<Any>) {
        this.fields = fields
        notifyDataSetChanged()
    }


    override fun getItemViewType(position: Int): Int {
        return if (fields[position] is String) {
            4
        } else {
            16
        }
    }

    override fun getItemCount(): Int {
        return fields.size
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        Log.e(TAG, "Position = $position")
        if (fields[position] is String) {
            val viewHolder = holder as HeadingViewHolder
            viewHolder.heading.text = fields[position].toString()
        } else {
            val viewHolder: ViewHolder = holder as ViewHolder
            val field = fields[position] as Field
            val editText = viewHolder.editText
            Log.e(TAG, "Label = ${field.apiName}   Value = ${valueMap[field.apiName]}  Req")
            viewHolder.textView.text = field.displayLabel
            editText.hint = field.displayLabel
            var inputType: Int = InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS
            if (field.required) {
                holder.mandatoryIcon.visibility = View.VISIBLE
            }
            when (field.dataType) {
                "text" -> inputType = InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS
                "phone" -> inputType = InputType.TYPE_CLASS_PHONE
                "email" -> inputType = InputType.TYPE_TEXT_VARIATION_EMAIL_ADDRESS
                "date" -> {
                    inputType = InputType.TYPE_DATETIME_VARIATION_DATE
                    isDate(viewHolder)
                }
                "picklist" -> {
                    isPickList(viewHolder, position)
                }
                "textarea" -> {
                    inputType = InputType.TYPE_TEXT_FLAG_MULTI_LINE
                    editText.isSingleLine = false
                    editText.imeOptions = EditorInfo.IME_FLAG_NO_ENTER_ACTION
                    editText.isVerticalScrollBarEnabled = true
                    editText.scrollBarStyle = View.SCROLLBARS_INSIDE_INSET
                    editText.setLines(5)
                    editText.maxLines = 8
                }
            }
            editText.inputType = inputType
            editText.setText(valueMap[field.apiName])

            editText.addTextChangedListener(object : TextWatcher {
                override fun afterTextChanged(s: Editable?) {
                }

                override fun beforeTextChanged(
                    s: CharSequence?,
                    start: Int,
                    count: Int,
                    after: Int
                ) {
                }

                override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                    valueMap[field.apiName] = s.toString()
                }
            })
        }

    }


    private fun isPickList(holder: ViewHolder, position: Int) {
        val field = fields[position] as Field
        holder.spinnerIcon.visibility = View.VISIBLE
        holder.spinnerIcon.setOnClickListener {
            onPickListClicked.pickListData(field.pickListValues, holder.editText)
        }
        holder.editText.setText(field.pickListValues[0].displayValue)
        holder.editText.isFocusable = false
        holder.editText.setOnClickListener {
            onPickListClicked.pickListData(field.pickListValues, holder.editText)
        }

    }

    interface OnPickListClicked {
        fun pickListData(pickValues: List<PickValues>, id: EditText)
    }

    private fun isDate(holder: ViewHolder) {
        val datePicker = DatePicker(context, holder.editText)
        holder.calendarIcon.visibility = View.VISIBLE
        holder.editText.setOnClickListener {
            datePicker.showDialog()
        }
        holder.editText.isFocusable = false
        holder.calendarIcon.setOnClickListener { datePicker.showDialog() }
    }

    class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val textView: TextView = itemView.findViewById(R.id.textView)
        val editText: EditText = itemView.findViewById(R.id.editText)
        val calendarIcon: ImageView = itemView.findViewById(R.id.calendarIcon)
        val spinnerIcon: ImageView = itemView.findViewById(R.id.spinnerIcon)
        val mandatoryIcon: ImageView = itemView.findViewById(R.id.mandatory)
    }

    class HeadingViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val heading: TextView = itemView.findViewById(R.id.heading)
    }

}