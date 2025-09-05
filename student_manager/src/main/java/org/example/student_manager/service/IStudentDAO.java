package org.example.student_manager.service;

import org.example.student_manager.model.Student;

import java.util.List;

public interface IStudentDAO {
    public boolean insertStudent(Student student) throws Exception;

    public Student selectStudent(int id);

    public List<Student> selectAllStudents();

    public boolean deleteStudent(int id) throws Exception;

    public boolean updateStudent(Student student) throws Exception;
}
