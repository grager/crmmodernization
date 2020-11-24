package com.castsoftware.crm

import android.content.Context
import android.graphics.Typeface
import android.view.View
import android.widget.*
import androidx.core.content.res.ResourcesCompat
import androidx.core.view.setMargins
import androidx.core.view.setPadding
import com.castsoftware.crm.dataclasses.contacts.AddContact
import com.castsoftware.crm.dataclasses.contacts.Data


class TableCreatingFunction(
    private val context: Context,
    private val crmContacts: List<Data>
) {

    private val onTableClicked = context as OnTableClicked

    private val keys =
        arrayOf("FirstName","LastName","DateOfBirth","Email","Phone")

    fun viewReturner(toSetHeight: Boolean = false): ScrollView {

        val scrollLayout = ScrollView(context)
        val scrollParams =
            if (!toSetHeight) {
                FrameLayout.LayoutParams(
                    FrameLayout.LayoutParams.WRAP_CONTENT,
                    FrameLayout.LayoutParams.WRAP_CONTENT
                )
            } else {
                FrameLayout.LayoutParams(FrameLayout.LayoutParams.WRAP_CONTENT, 546)
            }
        scrollLayout.layoutParams = scrollParams
        val layout = LinearLayout(context)
        val params = LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.WRAP_CONTENT,
            LinearLayout.LayoutParams.WRAP_CONTENT
        )
        layout.layoutParams = params
        layout.orientation = LinearLayout.VERTICAL
        layout.id = View.generateViewId()
        layout.addView(createTable(crmContacts))
        layout.setOnClickListener {
            onTableClicked.sendTable(crmContacts)
        }
        scrollLayout.addView(layout)
        return scrollLayout
    }


    private fun createTable(table: List<Data>): TableLayout {
        val layout = TableLayout(context)
        val params = TableLayout.LayoutParams(
            TableLayout.LayoutParams.WRAP_CONTENT,
            TableLayout.LayoutParams.WRAP_CONTENT
        )
        layout.layoutParams = params
        layout.id = View.generateViewId()
        layout.addView(headerCreator())
        //layout.getChildAt(0).setBackgroundColor(ContextCompat.getColor(context, R.color.gray_op20))
        table.forEach {
            layout.addView(createRows(it))
        }
//        layout.background = ContextCompat.getDrawable(
//            context,
//            R.drawable.rounded_corner
//        )
        return layout
    }

    private fun headerCreator(): TableRow {
        val row = TableRow(context)
        val params = TableRow.LayoutParams(
            TableRow.LayoutParams.WRAP_CONTENT,
            TableRow.LayoutParams.WRAP_CONTENT
        )
        row.layoutParams = params
        row.id = View.generateViewId()
        keys.forEach {
            row.addView(createTextView(it, true))
        }
        return row
    }

    private fun createRows(rows: Data): TableRow {
        val row = TableRow(context)
        val params = TableRow.LayoutParams(
            TableRow.LayoutParams.WRAP_CONTENT,
            TableRow.LayoutParams.WRAP_CONTENT
        )
        params.setMargins(16)
        row.layoutParams = params
        row.id = View.generateViewId()
        row.addView(createTextView(rows.firstName))
        row.addView(createTextView(rows.lastName))
        row.addView(createTextView(rows.dateOfBirth))
        row.addView(createTextView(rows.email))
        row.addView(createTextView(rows.mobile))
        return row
    }

    private fun createTextView(information: String, isHead: Boolean = false): TextView {
        val textView = TextView(context)
        textView.id = View.generateViewId()
        val params = TableRow.LayoutParams(
            TableRow.LayoutParams.WRAP_CONTENT,
            TableRow.LayoutParams.WRAP_CONTENT
        )
        params.setMargins(32, 16, 48, 16)
        textView.layoutParams = params
        textView.setPadding(8)
//        textView.setTextColor(
//            ContextCompat.getColor(
//                context,
//                R.color.white
//            )
//        )
        textView.typeface =
            Typeface.create(
                ResourcesCompat.getFont(
                    context,
                    R.font.roboto_slab
                ), Typeface.NORMAL
            )
        if (isHead) {
            textView.textSize = 24F
        }
        textView.text = information
        return textView
    }

    interface OnTableClicked {
        fun sendTable(tableData: List<Data>)
    }

}