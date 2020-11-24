package com.castsoftware.crm.dataclasses.crmlayouts


import com.google.gson.annotations.SerializedName

data class Profile(
    @SerializedName("default")
    val default: Boolean,
    @SerializedName("id")
    val id: String,
    @SerializedName("name")
    val name: String
)