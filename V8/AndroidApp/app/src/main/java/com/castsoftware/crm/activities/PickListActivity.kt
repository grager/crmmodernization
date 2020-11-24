package com.castsoftware.crm.activities

import android.app.Activity
import android.content.Intent
import android.graphics.Typeface
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.LinearLayout
import android.widget.TextView
import androidx.core.content.ContextCompat
import androidx.core.content.res.ResourcesCompat
import androidx.core.view.setMargins
import androidx.core.view.setPadding
import com.castsoftware.crm.R
import com.castsoftware.crm.dataclasses.crmlayouts.PickValues
import kotlinx.android.synthetic.main.activity_pick_list.*

class PickListActivity : AppCompatActivity() {

    private val TAG = PickListActivity::class.java.simpleName
    private lateinit var pickListValues : List<PickValues>

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_pick_list)

        val intent = intent
        val bundle = intent.getBundleExtra("data")
        val selectValue =  intent.getStringExtra("selectedValue")
        pickListValues = bundle?.getSerializable("data") as List<PickValues>
        Log.e(TAG,"Picklist size = ${pickListValues.size} Pick list = $pickListValues")
        pickListValues.forEach {
            pickListParent.addView(viewsReturner(it,selectValue))
            pickListParent.addView(line())
        }
    }

    private fun line() : View {
        val view = View(this)
        view.layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT,2)
        view.setBackgroundColor(ContextCompat.getColor(this,R.color.gray))
        return view
    }

    private fun viewsReturner(data : PickValues,selectedValue : String) : TextView{
        val textView = TextView(this)
        val params = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT,LinearLayout.LayoutParams.WRAP_CONTENT)
        //params.setMargins(8)
        textView.layoutParams = params
        textView.setPadding(24)
        textView.text = data.displayValue
        if(data.displayValue == selectedValue){
            textView.setBackgroundColor(ContextCompat.getColor(this,R.color.gray_op20))
            textView.setTextColor(ContextCompat.getColor(this,R.color.colorPrimary))
        }
        textView.textSize = 14F
        textView.typeface = ResourcesCompat.getFont(this,R.font.roboto_slab)
        textView.setOnClickListener {
            val intent = Intent()
            intent.putExtra("selectValue",data.displayValue)
            setResult(Activity.RESULT_OK,intent)
            finish()
        }
        return textView
    }

}
