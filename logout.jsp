<%@page contentType="text/html" pageEncoding="UTF-8"%>
	
<%
    session.removeAttribute("email");
    session.removeAttribute("utype");
    session.removeAttribute("checkFlag");
    session.removeAttribute("alertFlag");
    session.removeAttribute("date");
    
 
    session.invalidate();
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
    response.sendRedirect("index.jsp");
%>