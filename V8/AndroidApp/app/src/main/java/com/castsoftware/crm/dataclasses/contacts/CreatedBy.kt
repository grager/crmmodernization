package com.castsoftware.crm.dataclasses.contacts


import com.google.gson.annotations.SerializedName

data class CreatedBy(
    @SerializedName("email")
    val email: String,
    @SerializedName("id")
    val id: String,
    @SerializedName("name")
    val name: String
)