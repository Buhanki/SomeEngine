#version 460 core

out vec4 FragColor;

in vec3 FragPos;
in vec3 Normal;
in vec2 TexCoords;

struct Material{
  sampler2D diffuse;
  sampler2D specular;
  float     shininess;
};

struct Light {
  vec3 position;
  vec3 direction;
  float cutOff;
  float outerCutOff;
  
  vec3 ambient;
  vec3 diffuse;
  vec3 specular;

  float constant;
  float linear;
  float quadratic;
};

uniform vec3 viewPos;
uniform Light light;
uniform Material material;

void main()
{ 

  vec3 lightDir = normalize(light.position -FragPos);
  
  float theta = dot(lightDir, normalize(-light.direction));
  
  if (theta > light.cutOff)
  {
  float epsilon   = light.cutOff - light.outerCutOff;
  float intensity = clamp((theta - light.outerCutOff) / epsilon, 0.0, 1.0);  

      vec3 ambient = light.ambient * vec3(texture(material.diffuse, TexCoords));
  
  vec3 norm = normalize(Normal);
  float diff = max(dot(norm, lightDir), 0.0);
  
  vec3 diffuse = light.diffuse * diff * vec3(texture(material.diffuse, TexCoords));

  vec3 viewDir = normalize(viewPos - FragPos);
  vec3 reflectDir = reflect(-lightDir, norm);  
  float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);

  vec3 specular = light.specular * spec * vec3(texture(material.specular, TexCoords));  
  
  float distance    = length(light.position - FragPos);
  float attenuation = 1.0 / (light.constant + light.linear * distance +  light.quadratic * (distance * distance));
     
  /*ambient  *= attenuation; 
  diffuse  *= attenuation;
  specular *= attenuation;*/
  diffuse  *= intensity;
  specular *= intensity;

  FragColor = vec4(ambient + diffuse + specular, 1.0);

  }
  else
  {
    FragColor = vec4(light.ambient * vec3(texture(material.diffuse, TexCoords)), 1.0);
  }

  }


