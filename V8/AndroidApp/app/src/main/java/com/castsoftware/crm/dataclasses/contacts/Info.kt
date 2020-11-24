package com.castsoftware.crm.activities.dataclasses.contacts


import com.google.gson.annotations.SerializedName

data class Info(
    @SerializedName("count")
    val count: Int,
    @SerializedName("more_records")
    val moreRecords: Boolean,
    @SerializedName("page")
    val page: Int,
    @SerializedName("per_page")
    val perPage: Int
)