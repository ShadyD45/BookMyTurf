<%@ page import="java.sql.*,java.io.*,java.lang.*" %>
<%@ page import="UsersTurf.*" %>

<%
    //String sql=null;
    String utype=null;
    String vs = "V"; 
       /* Get User Data */
       String addr = request.getParameter("addr");
       String name = request.getParameter("name");
       String phno = request.getParameter("phone");
       String mail = request.getParameter("email");
       String psw = request.getParameter("psw");
        
      
       Users u1 = new Users();
       if(u1.checkEmail(mail))
       {
           out.print("<script>alert('The Email you entered is already in use. Try again with different email')</script>"); 
       }
       else
       {
            if(request.getParameter("tname") != null)
            {   
                Turf t1 = new Turf();
                utype="O";
                vs = "R";
                /* Get Turf Data */
               
                String taddr = request.getParameter("taddr");
                String tname = request.getParameter("tname");
                String tphone = request.getParameter("tphone");
                int rph = Integer.parseInt(request.getParameter("rph"));
                if(u1.insertUser(name,mail,addr,phno,utype,psw,vs))
                {
                    if(t1.insertTurf(tname,taddr,tphone,rph)){
                        out.print("<script>alert('Turf Registration and Sign up SuccessFull! Login with your Email')</script>");
                    }
                }
            }
            else{
                utype="P";
                if(u1.insertUser(name,mail,addr,phno,utype,psw,vs)){
                    out.print("<script>alert('Sign up success!! Please Login with your email')</script>"); 
                }
           }  
       }
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
    response.sendRedirect("index.jsp"); 
     
%>