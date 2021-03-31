package com.castsoftware.crm.dataclasses.crmlayouts


import com.google.gson.annotations.SerializedName

data class Layout(
    @SerializedName("created_by")
    val createdBy: Any,
    @SerializedName("created_for")
    val createdFor: Any,
    @SerializedName("created_time")
    val createdTime: Any,
    @SerializedName("id")
    val id: String,
    @SerializedName("modified_by")
    val modifiedBy: Any,
    @SerializedName("modified_time")
    val modifiedTime: Any,
    @SerializedName("name")
    val name: String,
    @SerializedName("profiles")
    val profiles: List<Profile>,
    @SerializedName("sections")
    val sections: List<Section>,
    @SerializedName("status")
    val status: Int,
    @SerializedName("visible")
    val visible: Boolean
)