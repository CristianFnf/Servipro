<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%
    HttpSession objsesion = request.getSession(false);
    String id_usuario = (String) objsesion.getAttribute("id_usuario");
    String Descripcion_perfil = (String) objsesion.getAttribute("descripcion_perfil");
    if (id_usuario == null) {
        response.sendRedirect("login.jsp");
    } else {
        if (Descripcion_perfil.equals("COORDINADOR")
                || Descripcion_perfil.equals("JEFE")) {

        } else {
            response.sendRedirect("nomina.htm");
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Editar Responsable por Grupo</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    </head>
    <body>
         <%
            Modelos.ResponsableGrupo.clsResponsableGrupo obclsResponsableGrupo = new Modelos.ResponsableGrupo.clsResponsableGrupo();

            if (request.getAttribute("obclsResponsableGrupo") != null) {
                obclsResponsableGrupo = (Modelos.ResponsableGrupo.clsResponsableGrupo) request.getAttribute("obclsResponsableGrupo");
            }

            List<Modelos.ResponsableGrupo.clsResponsableGrupo> lstclsResponsableGrupo = new ArrayList<Modelos.ResponsableGrupo.clsResponsableGrupo>();

            if (request.getAttribute("lstclsResponsableGrupo") != null) {

                lstclsResponsableGrupo = (List<Modelos.ResponsableGrupo.clsResponsableGrupo>) request.getAttribute("lstclsResponsableGrupo");
            }

            if (request.getAttribute("stMensaje") != null && request.getAttribute("stTipo") != null) {


        %>
        <input type="txt" hidden="" id="txtMensaje" value="<%=request.getAttribute("stMensaje")%>"/>
        <input type="txt" hidden="" id="txtTipo" value="<%=request.getAttribute("stTipo")%>"/>
        <script>
            var mensaje = document.getElementById("txtMensaje").value;
            var tipo = document.getElementById("txtTipo").value;
            swal("Mensaje", mensaje, tipo);
        </script>
        <%
            }
        %>
        <div class="container">
            <div class="card border-info">
                <div class="card-header bg-info text-white">
                    <div class="form-group">
                        <div class="form-group">
                            <div class="col-12 text-center">                                    
                                <h5 class="align-middle mt-1"> 
                                    <b><%=obclsResponsableGrupo.getObclsGrupo().getNombre()!= null ? obclsResponsableGrupo.getObclsGrupo().getNombre() : ""%></b>
                                </h5>                                         
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <form action="controlresponsablegrupo" method="POST">
                        <!--FILA-->
                        <div class="form-group">
                            <div class="row">
                                <div class="col-6">
                                    <label for="lblGrupo"><b>Grupo</b></label>
                                    <select class="form-control" name="ddlGrupo">
                                        <%
                                            List<Modelos.ResponsableGrupo.clsGrupo> lstclsGrupo = new ArrayList<Modelos.ResponsableGrupo.clsGrupo>();

                                            if (request.getAttribute("lstclsGrupo") != null) {
                                                lstclsGrupo = (List<Modelos.ResponsableGrupo.clsGrupo>) request.getAttribute("lstclsGrupo");
                                            }

                                            for (Modelos.ResponsableGrupo.clsGrupo elem : lstclsGrupo) {
                                        %>
                                        <option value="<%=elem.getId_grupo()%>"
                                                <%=obclsResponsableGrupo.getObclsGrupo() != null ? obclsResponsableGrupo.getObclsGrupo().getId_grupo() == elem.getId_grupo() ? "selected" : "" : ""%>>
                                            <%=elem.getNombre()%>
                                        </option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="col-6">
                                    <label for="lblUsuario"><b>Usuario</b></label>
                                    <select class="form-control" name="ddlUsuario">
                                           <%
                                            List<Modelos.ResponsableGrupo.clsUsuario> lstclsUsuario = new ArrayList<Modelos.ResponsableGrupo.clsUsuario>();

                                            if (request.getAttribute("lstclsUsuario") != null) {
                                                lstclsUsuario = (List<Modelos.ResponsableGrupo.clsUsuario>) request.getAttribute("lstclsUsuario");
                                            }

                                            for (Modelos.ResponsableGrupo.clsUsuario elem : lstclsUsuario) {
                                        %>
                                        <option value="<%=elem.getNro_usuario()%>"
                                                <%=obclsResponsableGrupo.getObclsUsuario() != null ? obclsResponsableGrupo.getObclsUsuario().getNro_usuario() == elem.getNro_usuario() ? "selected" : "" : ""%>>
                                             <%=elem.getEmpleado()%> (<%=elem.getId_usuario()%>)
                                        </option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!--FILA-->   
                        <div class="form-group">
                            <div class="form-row">
                                <div class="col-12">
                                    <input type="submit" value="Guardar" class="btn btn-info" data-toggle="tooltip" title="Haz clic para guardar" name="btnReGruEditar"/>
                                    <input type="text" name="IdModificar" id="IdModificar" value="<%=obclsResponsableGrupo.getId_responsable()%>" hidden=""/>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
