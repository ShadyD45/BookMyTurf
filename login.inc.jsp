<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.io.*,java.lang.*" %>
<%@ page import="UsersTurf.*" %>
<!DOCTYPE html>

<%
    String result = Login.loginCheck(request.getParameter("user"),request.getParameter("pwd"));
    
    if(result.equals("admin"))
    {
        session.setAttribute("email",Login.getEmail());
        session.setAttribute("utype",Login.getUtype());
        response.sendRedirect("admin.jsp");
    }
    if(result.equals("true"))
    {
	session.setAttribute("email",Login.getEmail());
        session.setAttribute("utype",Login.getUtype());
        session.setAttribute("uid",Login.getUid());
	response.sendRedirect("index.jsp");
    }
    
    if(result.equals("false"))
    {
	response.sendRedirect("index.jsp?status=false");
    }
 
    if(result.equals("error"))
    {
        response.sendRedirect("index.jsp?status=error");
    }
%>