package entities;

public class Usuario {
private String nombreUsuario;
private String Nombre;
private String apellido;
private String clave;
private String correo;
private int telefono;
private Boolean beneficio;
private Boolean admin;

public String getNombreUsuario() {
	return nombreUsuario;
}
public void setNombreUsuario(String nombreUsuario) {
	this.nombreUsuario = nombreUsuario;
}
public String getNombre() {
	return Nombre;
}
public void setNombre(String nombre) {
	Nombre = nombre;
}
public String getApellido() {
	return apellido;
}
public void setApellido(String apellido) {
	this.apellido = apellido;
}
public String getClave() {
	return clave;
}
public void setClave(String clave) {
	this.clave = clave;
}
public String getCorreo() {
	return correo;
}
public void setCorreo(String correo) {
	this.correo = correo;
}
public int getTelefono() {
	return telefono;
}
public void setTelefono(int telefono) {
	this.telefono = telefono;
}
public Boolean getBeneficio() {
	return beneficio;
}
public void setBeneficio(Boolean beneficio) {
	this.beneficio = beneficio;
}
public Boolean getAdmin() {
	return admin;
}
public void setAdmin(Boolean admin) {
	this.admin = admin;
}

}
