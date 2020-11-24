package com.castsoftware.crm.dataclasses.crmlayouts


import com.google.gson.annotations.SerializedName
import java.io.Serializable

data class PickValues(
    @SerializedName("actual_value")
    val actualValue: String,
    @SerializedName("display_value")
    val displayValue: String,
    @SerializedName("maps")
    val maps: List<Any>,
    @SerializedName("sequence_number")
    val sequenceNumber: Int
) : Serializable