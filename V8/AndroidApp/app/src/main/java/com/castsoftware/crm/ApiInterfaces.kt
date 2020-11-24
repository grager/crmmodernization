package com.castsoftware.crm

import com.castsoftware.crm.dataclasses.contacts.AddContactWrapper
import com.castsoftware.crm.dataclasses.contacts.AddResponse
import com.castsoftware.crm.dataclasses.contacts.CrmContacts
import com.castsoftware.crm.dataclasses.crmlayouts.ContactLayouts
import retrofit2.Call
import retrofit2.http.Body
import retrofit2.http.GET
import retrofit2.http.HeaderMap
import retrofit2.http.POST

interface ApiInterfaces {

    @Headers("Content-Type:application/json")
    @POST("auth")
    fun signin(@Body info: SignInBody): retrofit2.Call<ResponseBody>

    @GET("customers")
    fun getContacts(@HeaderMap header : HashMap<String,String>) : Call<CrmContacts>

    @POST("contacts")
    fun addContact(@Body contact : AddContactWrapper, @HeaderMap header : HashMap<String,String>) : Call<AddResponse>

    @GET("v2/settings/layouts?module=Contacts")
    fun getContactLayouts(@HeaderMap header : HashMap<String,String>) : Call<ContactLayouts>

    @POST("customers")
    fun addContact(@Body contact : HashMap<String,List<HashMap<String,String>>>, @HeaderMap header : HashMap<String,String>) : Call<AddResponse>

}
