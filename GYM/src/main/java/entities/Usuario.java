package entities;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Usuario {
	private static DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    private int id, telefono;
    private String username, password, email, nombre, apellido;
    private boolean beneficio, admin;
    private LocalDate fechaNac;
    
    
    public static DateTimeFormatter getFormato() {
		return formato;
	}
    
	public static void setFormato(DateTimeFormatter formato) {
		Usuario.formato = formato;
	}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public int getTelefono() {
		return telefono;
	}
	
	public void setTelefono(int telefono) {
		this.telefono = telefono;
	}
	
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getNombre() {
		return nombre;
	}
	
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	
	public String getApellido() {
		return apellido;
	}
	
	public void setApellido(String apellido) {
		this.apellido = apellido;
	}
	
	public boolean isBeneficio() {
		return beneficio;
	}
	
	public void setBeneficio(boolean beneficio) {
		this.beneficio = beneficio;
	}
	
	public boolean isAdmin() {
		return admin;
	}
	
	public void setAdmin(boolean admin) {
		this.admin = admin;
	}
	
	public LocalDate getFechaNac() {
		return fechaNac;
	}
	
	public void setFechaNac(LocalDate fechaNac) {
		this.fechaNac = fechaNac;
	}

	

}