package com.castsoftware.crm.activities.dataclasses.contacts


import com.google.gson.annotations.SerializedName

data class Approval(
    @SerializedName("approve")
    val approve: Boolean,
    @SerializedName("delegate")
    val `delegate`: Boolean,
    @SerializedName("reject")
    val reject: Boolean,
    @SerializedName("resubmit")
    val resubmit: Boolean
)