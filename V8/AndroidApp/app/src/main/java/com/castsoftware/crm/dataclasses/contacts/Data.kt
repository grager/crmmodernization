package com.castsoftware.crm.dataclasses.contacts


import com.google.gson.annotations.SerializedName
import com.castsoftware.crm.activities.dataclasses.contacts.Approval
import com.castsoftware.crm.activities.dataclasses.contacts.ModifiedBy
import com.castsoftware.crm.activities.dataclasses.contacts.Owner
import java.io.Serializable

data class Data(
    @SerializedName("First_Name")
    val firstName: String,
    @SerializedName("Last_Name")
    val lastName: String,
    @SerializedName("Email")
    val email: String,
    @SerializedName("Mobile")
    val mobile: String,
    @SerializedName("Date_of_Birth")
    val dateOfBirth: String,
    @SerializedName("Account_Name")
    val accountName: Any? = null,
    @SerializedName("\$approval")
    val approval: Approval? = null,
    @SerializedName("\$approved")
    val approved: Boolean? = null,
    @SerializedName("Assistant")
    val assistant: Any? = null,
    @SerializedName("Asst_Phone")
    val asstPhone: Any? = null,
    @SerializedName("Created_By")
    val createdBy: CreatedBy? = null,
    @SerializedName("Created_Time")
    val createdTime: String? = null,
    @SerializedName("\$currency_symbol")
    val currencySymbol: String? = null,
    @SerializedName("Department")
    val department: Any? = null,
    @SerializedName("Description")
    val description: Any? = null,
    @SerializedName("\$editable")
    val editable: Boolean? = null,
    @SerializedName("Email_Opt_Out")
    val emailOptOut: Boolean? = null,
    @SerializedName("Fax")
    val fax: Any? = null,
    @SerializedName("Full_Name")
    val fullName: String? = null,
    @SerializedName("Home_Phone")
    val homePhone: Any? = null,
    @SerializedName("id")
    val id: String? = null,
    @SerializedName("Last_Activity_Time")
    val lastActivityTime: Any? = null,
    @SerializedName("Lead_Source")
    val leadSource: Any? = null,
    @SerializedName("Mailing_City")
    val mailingCity: Any? = null,
    @SerializedName("Mailing_Country")
    val mailingCountry: Any? = null,
    @SerializedName("Mailing_State")
    val mailingState: Any? = null,
    @SerializedName("Mailing_Street")
    val mailingStreet: Any? = null,
    @SerializedName("Mailing_Zip")
    val mailingZip: Any? = null,
    @SerializedName("Modified_By")
    val modifiedBy: ModifiedBy? = null,
    @SerializedName("Modified_Time")
    val modifiedTime: String? = null,
    @SerializedName("\$orchestration")
    val orchestration: Any? = null,
    @SerializedName("Other_City")
    val otherCity: Any? = null,
    @SerializedName("Other_Country")
    val otherCountry: Any? = null,
    @SerializedName("Other_Phone")
    val otherPhone: Any? = null,
    @SerializedName("Other_State")
    val otherState: Any? = null,
    @SerializedName("Other_Street")
    val otherStreet: Any? = null,
    @SerializedName("Other_Zip")
    val otherZip: Any? = null,
    @SerializedName("Owner")
    val owner: Owner? = null,
    @SerializedName("Phone")
    val phone: Any? = null,
    @SerializedName("\$process_flow")
    val processFlow: Boolean? = null,
    @SerializedName("Record_Image")
    val recordImage: Any? = null,
    @SerializedName("Reporting_To")
    val reportingTo: Any? = null,
    @SerializedName("\$review")
    val review: Any? = null,
    @SerializedName("\$review_process")
    val reviewProcess: Any? = null,
    @SerializedName("Salutation")
    val salutation: Any? = null,
    @SerializedName("Secondary_Email")
    val secondaryEmail: Any? = null,
    @SerializedName("Skype_ID")
    val skypeID: Any? = null,
    @SerializedName("\$state")
    val state: String? = null,
    @SerializedName("Title")
    val title: Any? = null,
    @SerializedName("Twitter")
    val twitter: Any? = null
) : Serializable