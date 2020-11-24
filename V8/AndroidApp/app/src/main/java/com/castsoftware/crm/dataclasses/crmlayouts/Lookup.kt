package com.castsoftware.crm.dataclasses.crmlayouts


import com.google.gson.annotations.SerializedName

data class Lookup(
    @SerializedName("api_name")
    val apiName: String,
    @SerializedName("display_label")
    val displayLabel: String,
    @SerializedName("id")
    val id: String,
    @SerializedName("module")
    val module: String
)