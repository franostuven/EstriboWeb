<?php
cors();
include_once 'conexion.php';
$objeto = new Conexion();
$conexion = $objeto->Conectar();
//echo 'ENTRE AL CRUD';

$_POST = json_decode(file_get_contents("php://input"), true);
$opcion = (isset($_POST['opcion'])) ? $_POST['opcion'] : '';

$id = (isset($_POST['id_menu'])) ? $_POST['id_menu'] : '';
$id_link = (isset($_POST['id_link'])) ? $_POST['id_link'] : '';
$id_titulo = (isset($_POST['id_titulo'])) ? $_POST['id_titulo'] : '';
$descripcion_titulo = (isset($_POST['descripcion_titulo'])) ? $_POST['descripcion_titulo'] : '';
$id_menu = (isset($_POST['id_menu'])) ? $_POST['id_menu'] : '';
$descripcion_link = (isset($_POST['descripcion_link'])) ? $_POST['descripcion_link'] : '';
$path1 = (isset($_POST['path1'])) ? $_POST['path1'] : '';
$orden = (isset($_POST['orden'])) ? $_POST['orden'] : '';
$borrado = (isset($_POST['borrado'])) ? $_POST['borrado'] : '';
$imagen_path = (isset($_POST['imagen_path'])) ? $_POST['imagen_path'] : '';
$footer = (isset($_POST['footer'])) ? $_POST['footer'] : '';

/* $marca = (isset($_POST['marca'])) ? $_POST['marca'] : '';
$modelo = (isset($_POST['modelo'])) ? $_POST['modelo'] : '';
$stock = (isset($_POST['stock'])) ? $_POST['stock'] : '';
 */
switch($opcion){
    case 0:
        // INSERTA EN LA TABLA DE LINKS EL NUEVO LINK (LLAMADO DESDE LINKS.VUE)
        $consulta = "INSERT INTO links (id_titulo, descripcion_link, path1, orden, borrado) VALUES(?, ?, ?, ?, ?) ";	
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array($id_titulo, $descripcion_link, $path1, $orden, 0));                
        break;

    case 1:
     // saca los links de los menues (MENUES)
        $consulta = "SELECT menu_pantallas.descripcion_menu as label, menu_pantallas.url, 
                            menu_pantallas.icono as icon 
                       FROM menu_pantallas" ;
        $resultado = $conexion->prepare($consulta);
        $resultado->execute();                        
        $data=$resultado->fetchAll(PDO::FETCH_ASSOC);
        break;
        
    case 2: 
        // ACTUALIZA UN EDIT DE UN LINK (LLAMADO DESDE LINKS.VUE)
        $consulta = "UPDATE links SET id_titulo=?, descripcion_link=?, 
                            path1=?,  orden=?  
                      WHERE id_link=? ";		
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array($id_titulo, $descripcion_link, $path1, $orden, $id_link));                        
        $data=$resultado->fetchAll(PDO::FETCH_ASSOC);
        break;     

    case 3:
        // BORRA UN LINK SELECCIONADO (LLAMADO DESDE LINKS.VUE)  se hace un borrado logico
      //  $consulta = "DELETE FROM links WHERE id_link=? ";		
      $consulta = "UPDATE links SET borrado=?  
                    WHERE id_link=? ";		
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array(1, $id_link));                           
        break;         
 
    case 4:
        // saca los links de los menues (PANTALLA)
        $consulta = "SELECT menu_pantallas.id_menu, menu_pantallas.descripcion_menu, menu_pantallas.footer_pantalla  
                       FROM menu_pantallas 
                      WHERE menu_pantallas.id_menu = ?" ;
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array($id));                        
        $data=$resultado->fetchAll(PDO::FETCH_ASSOC);
        break;

    case 5:
        // saca los links de los menues (TITULOS)
        $consulta = "SELECT menu_pantallas.id_menu, titulos.id_titulo, titulos.descripcion_titulo, titulos.imagen_path, 
                            titulos.footer FROM menu_pantallas, titulos
                        WHERE menu_pantallas.id_menu = ? 
                        AND menu_pantallas.id_menu = titulos.id_menu
                        AND  titulos.borrado = 0"; 
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array($id));                        
        $data=$resultado->fetchAll(PDO::FETCH_ASSOC);
        break;

    case 6:
        // saca los links de los menues (ITEMS) 
        $consulta = "SELECT titulos.id_menu, titulos.id_titulo, links.descripcion_link, links.path1, links.orden  
                        FROM titulos, links 
                        WHERE titulos.id_menu = ? 
                        AND titulos.id_titulo = links.id_titulo 
                        AND  links.borrado = 0
                        AND  titulos.borrado = 0
                        ORDER BY links.orden";
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array($id));                        
        $data=$resultado->fetchAll(PDO::FETCH_ASSOC);
        break;        

    case 7:
        // OBTIENE EL ACCESO DE LOS USUARIOS Y PERMISOS  (Llamado desde el Login.vue)
        $consulta = "SELECT mail,clave FROM usuarios WHERE mail = ?";	
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array($id));                        
        $data=$resultado->fetchAll(PDO::FETCH_ASSOC);
        break;        

    case 8:
        // saca los links de los menues (PANILLA COMPLETA DE MENU-TITULOS Y LINKS)
        $consulta = "SELECT DISTINCT menu_pantallas.id_menu, menu_pantallas.descripcion_menu, titulos.id_titulo,  
                            titulos.descripcion_titulo, links.id_link, links.descripcion_link, links.path1, 
                            links.orden, links.borrado  
                        FROM menu_pantallas, titulos, links 
                        WHERE menu_pantallas.id_menu = titulos.id_menu  
                        AND titulos.id_titulo = links.id_titulo 
                        AND  links.borrado = 0
                        AND  titulos.borrado = 0
                        ORDER BY menu_pantallas.id_menu, titulos.id_titulo, links.orden";
        $resultado = $conexion->prepare($consulta);
        $resultado->execute();                        
        $data=$resultado->fetchAll(PDO::FETCH_ASSOC);
        break;        

    case 9:
        // Saca solo los Menues  para el DropDown (Llamado desde links.vue)
        $consulta = "SELECT menu_pantallas.id_menu, menu_pantallas.descripcion_menu
                        FROM menu_pantallas" ;
        $resultado = $conexion->prepare($consulta);
        $resultado->execute();                        
        $data=$resultado->fetchAll(PDO::FETCH_ASSOC);
        break;     
        
    case 10:
        // Saca solo los Titulos para el DropDown (Llamado desde links.vue)
        $consulta = "SELECT titulos.id_menu, menu_pantallas.descripcion_menu, titulos.id_titulo, titulos.descripcion_titulo, 
                            titulos.imagen_path, titulos.footer
                    FROM menu_pantallas, titulos
                   WHERE menu_pantallas.id_menu = titulos.id_menu
                     AND titulos.borrado = 0"; 
        $resultado = $conexion->prepare($consulta);
        $resultado->execute();                        
        $data=$resultado->fetchAll(PDO::FETCH_ASSOC);
        break;

    case 11:
        // BORRA UN TITULO Y TODOS SUS LINK ASOCIADOS (LLAMADO DESDE TARJETAS.VUE)  se hace un borrado logico
        //  $consulta = "DELETE FROM links WHERE id_link=? ";	
        
        $consulta = "UPDATE titulos SET borrado=?  
                    WHERE id_titulo=? ";		
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array(1, $id_titulo));      

        $consulta = "UPDATE links SET borrado=?  
                    WHERE id_titulo=? ";		
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array(1, $id_titulo));                           
        break;    
        
    case 12: 
        // ACTUALIZA UN EDIT DE UN TITULO (LLAMADO DESDE TARJETAS.VUE)
        $consulta = "UPDATE titulos SET id_menu=?,  descripcion_titulo=?, 
                            imagen_path=?,  footer=?  
                        WHERE id_titulo=? ";		
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array($id_menu, $descripcion_titulo, $imagen_path, $footer, $id_titulo));                        
        $data=$resultado->fetchAll(PDO::FETCH_ASSOC);
        break;    
        
    case 13:
        // INSERTA EN LA TABLA DE TITULO EL NUEVO TITULOS (LLAMADO DESDE TARJETAS.VUE)
        $consulta = "INSERT INTO titulos (id_menu, descripcion_titulo, imagen_path, footer) VALUES(?, ?, ?, ?) ";	
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(array($id_menu,  $descripcion_titulo, $imagen_path, $footer));                        
        break;
            
            
}

if(isset($data)){
    print json_encode($data, JSON_UNESCAPED_UNICODE);
}else{
    print 'ok';
}

$conexion = NULL;

/**
 *  An example CORS-compliant method.  It will allow any GET, POST, or OPTIONS requests from any
 *  origin.
 *
 *  In a production environment, you probably want to be more restrictive, but this gives you
 *  the general idea of what is involved.  For the nitty-gritty low-down, read:
 *
 *  - https://developer.mozilla.org/en/HTTP_access_control
 *  - https://fetch.spec.whatwg.org/#http-cors-protocol
 *
 */
function cors() {
    
    // Allow from any origin
    if (isset($_SERVER['HTTP_ORIGIN'])) {
        // Decide if the origin in $_SERVER['HTTP_ORIGIN'] is one
        // you want to allow, and if so:
        header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
        header('Access-Control-Allow-Credentials: true');
        header('Access-Control-Max-Age: 86400');    // cache for 1 day
    }
    
    // Access-Control headers are received during OPTIONS requests
    if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
        
        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
            // may also be using PUT, PATCH, HEAD etc
            header("Access-Control-Allow-Methods: GET, POST, OPTIONS");         
        
        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
            header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");
    
        exit(0);
    }
    
    //echo "You have CORS!";
}