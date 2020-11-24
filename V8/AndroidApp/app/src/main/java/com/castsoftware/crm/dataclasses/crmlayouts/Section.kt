package com.castsoftware.crm.dataclasses.crmlayouts


import com.google.gson.annotations.SerializedName

data class Section(
    @SerializedName("api_name")
    val apiName: String,
    @SerializedName("column_count")
    val columnCount: Int,
    @SerializedName("display_label")
    val displayLabel: String,
    @SerializedName("fields")
    val fields: List<Field>,
    @SerializedName("generated_type")
    val generatedType: String,
    @SerializedName("isSubformSection")
    val isSubformSection: Boolean,
    @SerializedName("name")
    val name: String,
    @SerializedName("properties")
    val properties: Any,
    @SerializedName("sequence_number")
    val sequenceNumber: Int,
    @SerializedName("tab_traversal")
    val tabTraversal: Int
)