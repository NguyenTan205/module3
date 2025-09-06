package org.example.student_manager.service;

import org.example.student_manager.model.Student;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO implements IStudentDAO {
    public static final String INSERT_STUDNETS_SQL = "insert into students (name, birthday, address, email, phone, averageGrade, className) values (?, ?, ?, ?, ?, ?, ?)";
    public static final String SELECT_STUDENT_BY_ID = "select id, name, birthday, address, email, phone, averageGrade, className from students where id = ?";
    public static final String SELECT_ALL_STUDENTS = "select * from students";
    public static final String DELETE_STUDENTS_SQL = "delete from students where id = ?";
    public static final String UPDATE_STUDENTS_SQL = "update students set name = ?, birthday = ?, address = ?, email = ?, phone = ?, averageGrade = ?, className = ? where id = ?";
    public static final String SELECT_BY_CLASSNAME = "SELECT * FROM students WHERE className LIKE ?";
    private String jdbcUrl = "jdbc:mysql://localhost:3306/student_manager";
    private String jdbcUsername = "root";
    private String jdbcPassword = "Tan23051994";

    public StudentDAO() {
    }

    protected Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, jdbcUsername, jdbcPassword);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return conn;
    }

    @Override
    public boolean insertStudent(Student student) throws Exception {
        boolean rowInserted = false;
        try (Connection conn = getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement(INSERT_STUDNETS_SQL)) {
            preparedStatement.setString(1, student.getName());
            preparedStatement.setString(2, student.getBirthday());
            preparedStatement.setString(3, student.getAddress());
            preparedStatement.setString(4, student.getEmail());
            preparedStatement.setString(5, student.getPhone());
            preparedStatement.setDouble(6, student.getAverageGrade());
            preparedStatement.setString(7, student.getClassName());

            rowInserted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            printSQLException(e);
        }
        return rowInserted;
    }

    @Override
    public Student selectStudent(int id) {
        Student student = null;
        try (Connection conn = getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement(SELECT_STUDENT_BY_ID)) {
            preparedStatement.setInt(1, id);
            System.out.println(preparedStatement);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                int studentId = rs.getInt("id");
                String name = rs.getString("name");
                String birthday = rs.getString("birthday");
                String address = rs.getString("address");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                double averageGrade = Double.parseDouble(rs.getString("averageGrade"));
                String className = rs.getString("className");
                student = new Student(studentId, name, birthday, address, email, phone, averageGrade, className);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return student;
    }

    @Override
    public List<Student> selectAllStudents() {
        List<Student> students = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement(SELECT_ALL_STUDENTS)) {
            System.out.println(preparedStatement);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String birthday = rs.getString("birthday");
                String address = rs.getString("address");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                double averageGrade = rs.getDouble("averageGrade");
                String className = rs.getString("className");
                students.add(new Student(id, name, birthday, address, email, phone, averageGrade, className));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return students;
    }

    @Override
    public boolean deleteStudent(int id) throws Exception {
        boolean rowDeleted = false;
        try (Connection conn = getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement(DELETE_STUDENTS_SQL)) {
            preparedStatement.setInt(1, id);
            rowDeleted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            printSQLException(e);
        }
        return rowDeleted;
    }

    // 🔹 Find by className (lọc theo lớp)
    public List<Student> findByClassName(String className) {
        List<Student> students = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BY_CLASSNAME)) {
            preparedStatement.setString(1, "%" + className + "%"); // LIKE '%className%'
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                Student s = mapResultSetToStudent(rs);
                students.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    // Map ResultSet → Student
    private Student mapResultSetToStudent(ResultSet rs) throws SQLException {
        int id = rs.getInt("id");
        String name = rs.getString("name");
        String birthday = rs.getString("birthday");
        String address = rs.getString("address");
        String email = rs.getString("email");
        String phone = rs.getString("phone");
        double averageGrade = rs.getDouble("averageGrade");
        String className = rs.getString("className");
        return new Student(id, name, birthday, address, email, phone, averageGrade, className);
    }

    // 🔹 Find by Name (tìm theo tên)
    public List<Student> findByName(String name) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students WHERE name LIKE ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + name + "%"); // tìm gần đúng
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Student student = new Student();
                student.setId(rs.getInt("id"));
                student.setName(rs.getString("name"));
                student.setBirthday(rs.getString("birthday"));
                student.setAddress(rs.getString("address"));
                student.setEmail(rs.getString("email"));
                student.setPhone(rs.getString("phone"));
                student.setAverageGrade(rs.getDouble("averageGrade"));
                student.setClassName(rs.getString("className"));
                students.add(student);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    public List<Student> selectStudentsByNamePage(String name, int offset, int noOfRecords) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students WHERE name LIKE ? LIMIT ?, ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + name + "%");
            ps.setInt(2, offset);
            ps.setInt(3, noOfRecords);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Student student = new Student();
                student.setId(rs.getInt("id"));
                student.setName(rs.getString("name"));
                student.setBirthday(rs.getString("birthday"));
                student.setAddress(rs.getString("address"));
                student.setEmail(rs.getString("email"));
                student.setPhone(rs.getString("phone"));
                student.setAverageGrade(rs.getDouble("averageGrade"));
                student.setClassName(rs.getString("className"));
                students.add(student);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    public int countStudentsByName(String name) {
        String sql = "SELECT COUNT(*) FROM students WHERE name LIKE ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Student> selectStudentsPage(int offset, int noOfRecords) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students LIMIT ?, ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, offset);
            ps.setInt(2, noOfRecords);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Student student = new Student();
                student.setId(rs.getInt("id"));
                student.setName(rs.getString("name"));
                student.setBirthday(rs.getString("birthday"));
                student.setAddress(rs.getString("address"));
                student.setEmail(rs.getString("email"));
                student.setPhone(rs.getString("phone"));
                student.setAverageGrade(rs.getDouble("averageGrade"));
                student.setClassName(rs.getString("className"));
                students.add(student);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    // Method đếm tổng sinh viên
    public int countStudents() {
        String sql = "SELECT COUNT(*) FROM students";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }


    @Override
    public boolean updateStudent(Student student) throws Exception {
        boolean rowUpdated = false;
        try (Connection conn = getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement(UPDATE_STUDENTS_SQL)) {
            preparedStatement.setString(1, student.getName());
            preparedStatement.setString(2, student.getBirthday());
            preparedStatement.setString(3, student.getAddress());
            preparedStatement.setString(4, student.getEmail());
            preparedStatement.setString(5, student.getPhone());
            preparedStatement.setDouble(6, student.getAverageGrade());
            preparedStatement.setString(7, student.getClassName());
            preparedStatement.setInt(8, student.getId());

            rowUpdated = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            printSQLException(e);
        }
        return rowUpdated;
    }

    // 🔹 Lọc theo lớp + phân trang
    public List<Student> findByClassNamePage(String className, int offset, int noOfRecords) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students WHERE className LIKE ? LIMIT ?, ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + className + "%");
            ps.setInt(2, offset);
            ps.setInt(3, noOfRecords);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                students.add(mapResultSetToStudent(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    // 🔹 Đếm số sinh viên theo lớp (để tính totalPages)
    public int countStudentsByClassName(String className) {
        String sql = "SELECT COUNT(*) FROM students WHERE className LIKE ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + className + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }


    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
