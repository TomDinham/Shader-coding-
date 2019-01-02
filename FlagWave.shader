Shader "Custom/FlagWave" 
{
	Properties 
	{
	_Tex ("Texture", 2D) = "white" {} // setting up a texture property so a texture can be applied to the material
	_Freq ("Wave Frequency", Range(0,10)) = 5 // Setting up a Property for the wave frequency so it can be adjusted within unity 
	_Amp ("Wave Amplitude", Range(0,1)) = 1//setting up a Amplitude property so it can be adjusted within unity
	_tint("Tint Level", Range(0,1)) = 0.5 // setting up a Tint property so it can be adjusted within unity
	_Top("Top Colour", Color) = (1,1,1,1) //setting up a colour property so you can change the top colour of the material
	_Bottom("Top Colour", Color) = (1,1,1,1) // setting up a colour property so you can change the bottom colour of the material
	}
	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert vertex:vert //setting the lighting model to a vertex level model
		#pragma target 3.0

		sampler2D _Tex;//setting up a 2d texture variable for the texture
		float _Freq; //setting up a float variable for the frequency
		float _tint; //Setting up a #float variable for the tint value
		float _Amp; //Setting up a float variable for the Amplitude
		float4 _Top; // setting up a float,  with 4 data members, variable for the top colour
		float4 _Bottom; //setting up a float, with 4 data members, variable for the bottom color



		struct Input 
		{
			float2 uv_Tex;///Sending the values of Tex into the input
			float3 vertColor;//sending the values of vertcolor into the input;
			float3 vertNormal;//sending the values of vertnormal into the input
		};

		void vert(inout appdata_full v, out Input o)
		{
		   UNITY_INITIALIZE_OUTPUT(Input,o);//initialising the output
		   float time = _Time * _Freq; //Creating the variable of time and initilising it as time * frequency
		   float offset = v.vertex.x; // creating the offset variable and initializing a postion along the x axis of the model
		   float height = sin(time + offset * _Amp * 2);  //creating a value of height and using the sin function to return a value between 1 and -1
		   o.vertColor = float3 (height,height,height);// setting the input vertex color based on the hight of the ripples
		   v.vertex.xyz = float3(v.vertex.x, v.vertex.y + height, v.vertex.z);//Setting the models vertex valuse so the y axis is affected by the height
		   o.vertNormal = normalize(float3 (-cos(time+offset), 1.0, v.normal.z));//setting the input structrues normal axis to the values calculated


		}
		void surf (Input IN, inout SurfaceOutput o) 
		{
			half4 c = tex2D (_Tex, IN.uv_Tex);//setting a half4 variable to the values of the texture and its uv values
			float3 tintCol = lerp(_Bottom, _Top, IN.vertColor).rgb;//setting the tintcolor  variable to the rgb values of the top, bottom and vertex colors of the model
			o.Albedo = c.rgb * (tintCol * _tint);//Setting the output albedo values of the textures RGB and the tint colour by its amount of tint
			o.Alpha = c.a; //setting the output alpha value to the same as the textures
			o.Normal = IN.vertNormal;//setting the output normals to the vet normals from the input structure

		}
		ENDCG
	}
	FallBack "Diffuse"
}
