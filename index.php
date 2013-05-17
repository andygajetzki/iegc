<?php
//ini_set("display_errors", 1);
//load periodic


function array_compress($array)
{
    $aReturn = array();
    foreach($array as $value)
    if (strlen($value) > 0) {
        $aReturn[] = $value;
    }
    return $aReturn;
}

function getPathVariables()
{
    $sPathPS = $_SERVER['PHP_SELF'];
    $sPathFS = __FILE__;

    $aPathPS = array_reverse(explode("/", $sPathPS));
    $aPathFS = array_reverse(explode("/", $sPathFS));

    $aReturn = array();
    $x = 0;

    while (@$aPathPS[$x] != @$aPathFS[$x] && @$aPathPS[$x] != @$aPathFS[0] ) {
        array_unshift($aReturn, @$aPathPS[$x]);
        $x++;
    }

    $aReturn = array_compress($aReturn);
    array_shift($aReturn);
    return $aReturn;


}

$periodic = DOMDocument::load("periodic.xml");

//load xslt
$xslt = new XSLTProcessor;
$xslt->importStyleSheet(DOMDocument::load("elements.xslt"));


$x = getPathVariables();
if ( $x[0] != NULL ) {
    
$e1 = $x[0];
$e2 = 0;
$an = "atomic_number";
$e1en = "";
$e1name = "";

// load simplexml of pt
$pt = simplexml_import_dom($periodic);



foreach ( $pt->table->tr as $tr ) {
    foreach ($tr->td as $td) {
        
       if ( $td['class'] == 'element' ) {
        
        if ( $td->atom->atomic_number == $e1 ) {
            $e1name =  $td->atom->name;
            $e1en = $td->atom->electronegativity;
        }
        
       }

}
}


foreach ( $pt->table->tr as $tr ) {
    foreach ($tr->td as $td) {
        
       if ( $td['class'] == 'element' ) {

        $diff = abs((float)$e1en - (float)$td->atom->electronegativity);
	
	if ( $diff == 0 ) {
	
		$td->atom['color'] = "#FFFFFF";

}    else 
        if ( $diff < 0.4 ) {
            
            $td->atom['color'] = "#A6CAF0";
            
        } else 
        if ( $diff >= 0.4 && $diff < 1.8 ) {
            
            $td->atom['color'] = "#FFA07A";
            
        }
        else 
        if ( $diff >= 1.8 ) {
            
            $td->atom['color'] = "#FF6347";
            
        }
        
        
       }

}
}

}

echo $xslt->transformToXML($periodic);





//convert elements.xml elements.html




?>