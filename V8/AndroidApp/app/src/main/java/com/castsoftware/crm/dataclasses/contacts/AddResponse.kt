package com.castsoftware.crm.dataclasses.contacts

import com.google.gson.annotations.SerializedName

data class AddResponse(

    @SerializedName("data")
    val data : List<DataResponse>

)

data class DataResponse(

    @SerializedName("code")
    val code : String

)