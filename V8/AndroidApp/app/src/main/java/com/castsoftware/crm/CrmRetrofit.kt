package com.castsoftware.crm

import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

class CrmRetrofit {

    companion object {

        @Volatile
        private var INSTANCE: Retrofit? = null
        fun getRetrofit(): Retrofit {
            val tempInstance = INSTANCE
            if (tempInstance != null) {
                return tempInstance
            }
            synchronized(this) {
                val instance = Retrofit.Builder()
                    .baseUrl(ApiEssentials.BASE_URL)
                    .client(getClient())
                    .addConverterFactory(GsonConverterFactory.create())
                    .build()
                INSTANCE = instance
                return instance
            }
        }

        @Volatile
        private var API: ApiInterfaces? = null
        fun getApi(): ApiInterfaces {
            val tempInstance = API
            if (tempInstance != null) {
                return tempInstance
            }
            synchronized(this) {
                val instance = INSTANCE!!.create(ApiInterfaces::class.java)
                API = instance
                return instance
            }

        }

        private fun getClient(): OkHttpClient {
            val interceptor = HttpLoggingInterceptor()
            interceptor.level = HttpLoggingInterceptor.Level.BODY
            val builder: OkHttpClient.Builder = OkHttpClient.Builder()
                .connectTimeout(50, TimeUnit.SECONDS)
                .readTimeout(60, TimeUnit.SECONDS)
            builder.addNetworkInterceptor(interceptor)
            return builder.build()
        }

    }


}