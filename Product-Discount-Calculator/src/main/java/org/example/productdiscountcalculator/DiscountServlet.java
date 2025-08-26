package org.example.productdiscountcalculator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "DiscountServlet", value = "/display-discount")
public class DiscountServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy dữ liệu từ form
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        double discountPercent = Double.parseDouble(request.getParameter("discountPercent"));

        // Tính toán
        double discountAmount = price * discountPercent * 0.01;
        double discountPrice = price - discountAmount;

        // Xuất kết quả ra HTML
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<html><head><title>Discount Result</title></head><body>");
        out.println("<h2>Product Discount Calculator Result</h2>");
        out.println("<p><b>Product Description:</b> " + description + "</p>");
        out.println("<p><b>List Price:</b> $" + price + "</p>");
        out.println("<p><b>Discount Percent:</b> " + discountPercent + "%</p>");
        out.println("<p><b>Discount Amount:</b> $" + discountAmount + "</p>");
        out.println("<p><b>Discount Price:</b> $" + discountPrice + "</p>");
        out.println("<a href='index.jsp'>Back</a>");
        out.println("</body></html>");
    }
}
