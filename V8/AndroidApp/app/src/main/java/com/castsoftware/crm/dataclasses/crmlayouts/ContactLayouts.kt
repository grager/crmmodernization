package com.castsoftware.crm.dataclasses.crmlayouts


import com.google.gson.annotations.SerializedName

data class ContactLayouts(
    @SerializedName("layouts")
    val layouts: List<Layout>
)