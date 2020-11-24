package com.castsoftware.crm.dataclasses.contacts

import com.google.gson.annotations.SerializedName

data class AddContact(

    @SerializedName("First_Name")
    val firstName : String,

    @SerializedName("Last_Name")
    val lastName : String,

    @SerializedName("Email")
    val email : String,

    @SerializedName("Mobile")
    val mobile : String,

    @SerializedName("Date_of_Birth")
    val dob : String

)

data class AddContactWrapper(

    @SerializedName("data")
    val data : List<AddContact>

)