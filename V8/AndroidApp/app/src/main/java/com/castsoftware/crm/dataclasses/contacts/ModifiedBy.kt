package com.castsoftware.crm.activities.dataclasses.contacts


import com.google.gson.annotations.SerializedName

data class ModifiedBy(
    @SerializedName("email")
    val email: String,
    @SerializedName("id")
    val id: String,
    @SerializedName("name")
    val name: String
)