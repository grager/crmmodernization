package com.castsoftware.crm.dataclasses.crmlayouts


import com.google.gson.annotations.SerializedName

data class ViewType(
    @SerializedName("create")
    val create: Boolean,
    @SerializedName("edit")
    val edit: Boolean,
    @SerializedName("quick_create")
    val quickCreate: Boolean,
    @SerializedName("view")
    val view: Boolean
)