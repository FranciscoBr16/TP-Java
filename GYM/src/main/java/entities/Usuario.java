package entities;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class Usuario {
	
    private String telefono;
    private String dni, password, email, nombre, apellido;
    private boolean beneficio, admin;
    private LocalDate fechaNac;
	private String imagen;
	private ArrayList<Contrato> contratos= new ArrayList<>(); 
	private ArrayList<Inscripcion> inscripciones= new ArrayList<>();
	
	
	public ArrayList<Inscripcion> getInscripciones() {
		return inscripciones;
	}

	public void setInscripciones(ArrayList<Inscripcion> inscripciones) {
		this.inscripciones = inscripciones;
	}

	public ArrayList<Contrato> getContratos() {
		return contratos;
	}

	public void setContratos(ArrayList<Contrato> contratos) {
		this.contratos = contratos;
	}

	public String getImagen() {
		return imagen;
	}
	
	
	public String getTelefono() {
		return telefono;
	}
	
	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	
	public String getDni() {
		return dni;
	}
	
	public void setDni(String dni) {
		this.dni = dni;
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

	public Usuario(String dni, String nombre, String apellido, String password, String email , String telefono, LocalDate fecha, String img) {
		this.dni = dni;
		this.nombre = nombre;
		this.apellido = apellido;
		this.password = password;
		this.email = email;
		this.telefono = telefono;
		this.fechaNac = fecha;
		this.admin = false;
		this.imagen = img;
	}

	public Usuario(String dni, String password) {
		this.dni = dni;
		this.password = password;
	}



	public void setImagen(String imagen) {
		this.imagen = imagen;
		
	}
	
	
	

	

}