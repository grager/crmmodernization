package com.castsoftware.crm.dataclasses.crmlayouts


import com.google.gson.annotations.SerializedName

data class Field(
    @SerializedName("api_name")
    val apiName: String,
    @SerializedName("association_details")
    val associationDetails: Any,
    @SerializedName("auto_number")
    val autoNumber: AutoNumber,
    @SerializedName("blueprint_supported")
    val blueprintSupported: Boolean,
    @SerializedName("created_source")
    val createdSource: String,
    @SerializedName("crypt")
    val crypt: Any,
    @SerializedName("currency")
    val currency: Currency,
    @SerializedName("custom_field")
    val customField: Boolean,
    @SerializedName("data_type")
    val dataType: String,
    @SerializedName("decimal_place")
    val decimalPlace: Any,
    @SerializedName("default_value")
    val defaultValue: Any,
    @SerializedName("display_label")
    val displayLabel: String,
    @SerializedName("field_label")
    val fieldLabel: String,
    @SerializedName("field_read_only")
    val fieldReadOnly: Boolean,
    @SerializedName("formula")
    val formula: Formula,
    @SerializedName("history_tracking")
    val historyTracking: Boolean,
    @SerializedName("id")
    val id: String,
    @SerializedName("json_type")
    val jsonType: String,
    @SerializedName("length")
    val length: Int,
    @SerializedName("lookup")
    val lookup: Lookup,
    @SerializedName("multi_module_lookup")
    val multiModuleLookup: MultiModuleLookup,
    @SerializedName("multiselectlookup")
    val multiselectlookup: Multiselectlookup,
    @SerializedName("pick_list_values")
    val pickListValues: List<PickValues>,
    @SerializedName("read_only")
    val readOnly: Boolean,
    @SerializedName("required")
    val required: Boolean,
    @SerializedName("section_id")
    val sectionId: Int,
    @SerializedName("sequence_number")
    val sequenceNumber: Int,
    @SerializedName("subform")
    val subform: Any,
    @SerializedName("system_mandatory")
    val systemMandatory: Boolean,
    @SerializedName("tooltip")
    val tooltip: Any,
    @SerializedName("unique")
    val unique: Unique,
    @SerializedName("validation_rule")
    val validationRule: Any,
    @SerializedName("view_type")
    val viewType: ViewType,
    @SerializedName("visible")
    val visible: Boolean,
    @SerializedName("webhook")
    val webhook: Boolean
)