package org.example.student_manager.model;

public class Student {
    private int id;
    private String name;
    private String birthday;
    private String address;
    private String email;
    private String phone;
    private double averageGrade;
    private String className;


    public Student() {}

    public Student(String name, String birthday, String address, String email, String phone, double averageGrade, String className) {
        super();
        this.setName(name);
        this.setBirthday(birthday);
        this.setAddress(address);
        this.setEmail(email);
        this.setPhone(phone);
        this.setAverageGrade(averageGrade);
        this.setClassName(className);
    }

    public Student(int id, String name, String birthday, String address, String email, String phone, double averageGrade, String className) {
        super();
        this.setId(id);
        this.setName(name);
        this.setBirthday(birthday);
        this.setAddress(address);
        this.setEmail(email);
        this.setPhone(phone);
        this.setAverageGrade(averageGrade);
        this.setClassName(className);
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public double getAverageGrade() {
        return averageGrade;
    }

    public void setAverageGrade(double averageGrade) {
        this.averageGrade = averageGrade;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }
}
