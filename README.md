# ICG-In-Class-Review

**Part 1: Create Github: 4 minutes**

**Part 2: Forward & Deferred Rendering: 20 minutes**

Forward rendering is a linear way to pass geometry down the pipeline to produce a final image of the object with light added to it from the scene.

Deferred rendering is a more efficient way to add light to an object, it also passes geometry down the pipeline, but it uses the g-buffer to store lighting data and textures before rendering light onto the final image, adding another step.


![image](https://user-images.githubusercontent.com/94996976/228622501-73a6e1ff-41a1-42b6-a377-8d9a6b634b0c.png)
![image](https://user-images.githubusercontent.com/94996976/228622563-c7ecc523-ef98-44ab-85d2-003416c418be.png)

**Part 3: Jaws and toon ramp square wave water 1hr 20**

Textures from FreePbr
![image](https://user-images.githubusercontent.com/94996976/228622698-0da1d256-f623-493c-a5cf-d5dbe66888c5.png)
Explanation: For the square waves, I simply included an if statement based on the wavelength that would ask if the wavelength was above a certain threshold, to set it to a specific wavelength value. In my case I asked:![image](https://user-images.githubusercontent.com/94996976/228622761-e48b1032-70eb-4e37-9485-b78d50db3e23.png)
It would set the wavelength to -1 if waveHeight wasn’t over 0.1. 
For the shader, I added the toonramp lighting to the water shader taught in class to accommodate the toon lighting requirement.
![image](https://user-images.githubusercontent.com/94996976/228622913-c0508bde-0169-4ae3-8cb2-420fda82beae.png)

**Part 4: Explain Code 20 minutes**

RenderTexture[] textures = new RenderTexture[16]; -> Progressively upsamples iteratively

for (; i < iterations; i++) { -> Downsampling iterations loop, helps with detail despite lower resolution
width /= 2;
height /= 2;

for (; i < iterations; i++) { -> upsampling iteration loop
Graphics.Blit(currentSource,currentDestination);
}
Graphics.Blit(currentSource, destination);
}

This is part of a c# code for a blur shader. It functions by downsampling the image rendered by the camera.
This blur effect could be used as a screen effect in response to an in-game event such as taking damage.

**Part 5: Bloom and Outlining** - 40 minutes(Shark texture from cgaxis)
![image](https://user-images.githubusercontent.com/94996976/228623907-b08ec54d-7681-49db-84d1-b31bbb3ed61f.png)
- Bloom was applied to a camera to further enhance the sunny day look and to brighten the water.
- The outline was applied to the shark and cannon objects in the scene on them a cartoony look.
- I added toon ramp lighting as well as a bump map to the outline shader from class which is an addon to what was previously just a main texture property.
![image](https://user-images.githubusercontent.com/94996976/228624025-2342e608-ba57-40e8-92d0-c346b0c55cd3.png)
![image](https://user-images.githubusercontent.com/94996976/228624070-330d3d64-81fb-4164-b31c-0aaf7953792b.png)
- The bloom shader is the same as the one from the lecture.

**Part 6: Explain Code 20 minutes**

_ShadowColor("Shadow Color", Color) = (1,1,1,1)-> Setting inspector property to modify colour outside of script

sampler2D _MainTex;
fixed4 _Color;
fixed4 _ShadowColor; -> Define variables within subshader

half4 LightingCSLambert(SurfaceOutput s, half3 lightDir, half atten) { -> Outputs all final colour values. Uses atten value to figure out how shadows are displayed based on the brightness of the surface it’s being rendered on.

c.rgb += _ShadowColor.xyz * (1.0 - atten);
c.a = s.Alpha; - uses shadow colour value defined by the user to output shadow colour.

- This code renders the shadow of an object so that it can either have shadows casted onto it or so it can cast shadows onto other objects. What is different about this code than a regular shadow caster is that this code changes the colour of the shadow being rendered.
- This shadow code could be used if you are trying to achieve a more cartoony or colourful art style and don’t want the shadows to be coloured black and simply differed by opacity. You could also give different objects different coloured shadows with this shader.

**Part 7: Scrolling Texture 14 minutes**
- This shader displaces the uv of the texture over time so that it seems as if the texture is moving but the object is staying in place.
![image](https://user-images.githubusercontent.com/94996976/228624446-e0da4639-8c90-437f-96d0-def14643e0f6.png)
- This shader could be used to simulate a skybox/moving clouds, water, a moving background in a side scroller, or any sort of menu ticker or moving screen/billboard.

![image](https://user-images.githubusercontent.com/94996976/228624505-4db0273d-57a9-40a5-9a3e-794aa09b2ec4.png)
