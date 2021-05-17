<?php
//session_start();
if (!isset($_SESSION['apriori_resep_id'])) {
    header("location:index.php?menu=forbidden");
}

include_once "database.php";
include_once "fungsi.php";
include_once "import/excel_reader2.php";
?>
<div class="main-content">
    <div class="main-content-inner">
        <div class="page-content">
            <div class="page-header">
                <h1>
                    Data Rekomendasi
                </h1>
            </div><!-- /.page-header -->
<?php
//object database class
$db_object = new database();

$pesan_error = $pesan_success = "";
if(isset($_GET['pesan_error'])){
    $pesan_error = $_GET['pesan_error'];
}
if(isset($_GET['pesan_success'])){
    $pesan_success = $_GET['pesan_success'];
}

if(isset($_GET['action'])=="delete"){
    $id = $_GET['id'];
    $table = "temporary";

    $sql = "DELETE FROM temporary WHERE id=";
    $sql .= "$id";
    $db_object->db_query($sql);
    ?>
    <script> location.replace("?menu=rekomendasi&pesan_success=Data yang dipilih berhasil dihapus"); </script>
    <?php
}

if(isset($_POST['find'])){
    $table = "temporary";
    $sql = "SELECT
    *
    FROM
    temporary";
    $query=$db_object->db_query($sql);
    $jumlah=$db_object->db_num_rows($query);
    $data = '';
    while($row=$db_object->db_fetch_array($query)){
        $data.=" ".$row['menu'];
    }
    
    $table2 = "transaksi";
    $sql2 = "SELECT
    *
    FROM
    transaksi";
    $query2=$db_object->db_query($sql2);
    $jumlah2=$db_object->db_num_rows($query2);
    $temp ="";
    $totalScore = 0;
    while($row=$db_object->db_fetch_array($query2)){
        $temp=similar_text($data,$row['produk']);
        $id = $row['id'];
        $table = "transaksi";
        $sql = "UPDATE transaksi SET score=".$temp." WHERE id=";
        $sql .= "$id";
        $db_object->db_query($sql);
        $totalScore = $totalScore + $temp;
    }
    $average = $totalScore / $jumlah2;
    $sql3 = "SELECT
    *
    FROM
    transaksi WHERE score>=$average ORDER BY score DESC";
    
    $query3=$db_object->db_query($sql3);
    $jumlah3=$db_object->db_num_rows($query3);
    ?>
  
   <?php
}


if(isset($_POST['submit'])){
    // if(!$input_error){
    if (empty($_POST['bahan']))
    {
     ?>
     <script> location.replace("?menu=rekomendasi&pesan_error=Silahkan Bahan Makanan Yang Kamu Miliki"); </script>
     <?php
    }else{
        
            $temporary = "SELECT
            *
            FROM
            temporary";
            $query=$db_object->db_query($temporary);
            $jumlah=$db_object->db_num_rows($query);
            if($jumlah<3){
                $data = $_POST['bahan'];
                $table = "temporary";

                $sql = "INSERT INTO temporary (menu) VALUES";
                $sql .= " ('$data')";
                $db_object->db_query($sql);
                ?>
                  <script> location.replace("?menu=rekomendasi&pesan_success=Data berhasil disimpan kedatabase"); </script>
                <?php 
            } else{
        ?>  
            <script> location.replace("?menu=rekomendasi&pesan_error=Maksimal Item Yang Dapat Diinputkan Hanya 3"); </script>
        <?php } ?>
            
    <?php
    }
}

if(isset($_POST['delete'])){
    $sql = "TRUNCATE temporary";
    $db_object->db_query($sql);
    ?>
        <script> location.replace("?menu=rekomendasi&pesan_success=Data bahan makanan berhasil dihapus"); </script>
        <?php
}

$sql = "SELECT
        *
        FROM
         temporary";
$query=$db_object->db_query($sql);
$jumlah=$db_object->db_num_rows($query);
?>            
<div class="row">
    <div class="col-sm-4">
        <div class="widget-box">
        <!--UPLOAD EXCEL FORM-->
        <form method="post" enctype="multipart/form-data" action="">
            <div class="widget-body">
                <div class="widget-main">
                    <div class="form-group">
                        <input type="text" class="form-control" name="bahan" placeholder="Ketik bahan yang kamu punya disini"/>

                        <button name="submit" type="submit" value="" class="btn btn-app btn-primary btn-sm " style="margin-top:10px;">
                            <i class="ace-icon fa fa-save bigger-200"></i> Input
                        </button>
                        <button name="delete" type="submit"  class="btn btn-app btn-danger btn-sm"  style="margin-top:10px;"
                                onclick="return confirm('Ingin hapus semua bahan yang telah kamu masukan?')" >
                            <i class="ace-icon fa fa-trash-o bigger-200"></i> Delete
                        </button>
                        
                        <button name="find" type="submit"  class="btn btn-success btn-sm" style="margin-top:10px;">
                            <i class="ace-icon fa fa-search bigger-200"></i> Cari Rekomendasi
                        </button>
                        
                        <span style="font-size:10px;">*Maksimal Input 3 Item</span>
                    </div>
                </div>
            </div>
        </form>
        </div>
    </div>
    <?php if($jumlah3>0) { ?>
    <div class="col-sm-8">
        <div class="widget-box">
            <p style="margin-left:10px;font-weight:bold;margin-top:5px;">Resep yang paling mungkin untuk bahan yang kamu miliki yaitu : </p>
            <table class='table table-bordered table-striped  table-hover'>
                <tr>
                <th>No</th>
                <th>Menu</th>
                <th>Referensi</th>
                </tr>
                <?php
                    $no = 1;
                    while($row=$db_object->db_fetch_array($query3)){
                        echo "<tr>";
                            echo "<td>".$no."</td>";
                            echo "<td>".$row['menu']."</td>";
                            echo "<td><a href='".$row['ref']."' target='_blank' >".$row['ref']."</a></td>";
                        echo "</tr>";
                        $no++;
                    }
                    ?>
            </table>
        </div>
    </div>
</div>

<?php } ?>
            <div class="row">
                <div class="col-sm-12">
                    <div class="widget-box">
                        <div class="widget-body">
                            <div class="widget-main">
                                <?php
                                if (!empty($pesan_error)) {
                                    display_error($pesan_error);
                                }
                                if (!empty($pesan_success)) {
                                    display_success($pesan_success);
                                }

                                echo "Jumlah data: ".$jumlah."<br>";
                                if($jumlah==0){
                                    echo "Data kosong...";
                                }
                                else{
                                ?>
                                <table class='table table-bordered table-striped  table-hover'>
                                    <tr>
                                    <th>No</th>
                                    <th>Bahan</th>
                                    <th>Aksi</th>
                                    </tr>
                                    <?php
                                        $no=1;
                                        while($row=$db_object->db_fetch_array($query)){
                                            echo "<tr>";
                                                echo "<td>".$no."</td>";
                                                echo "<td>".$row['menu']."</td>";
                                                echo "<td> <a href='index.php?menu=rekomendasi&action=delete&id=".$row['id']."'". "class='btn btn-app btn-danger btn-sm' > Delete
                                                </a></td>";
                                            echo "</tr>";
                                            $no++;
                                        }
                                        ?>
                                </table>
                                <?php
                                }
                                ?>
                            </div>
                        </div>
                    </div>
                 </div>
            </div>
        </div>
    </div>
</div>

<?php
function get_produk_to_in($produk){
    $ex = explode(",", $produk);
    //$temp = "";
    for ($i=0; $i < count($ex); $i++) { 

        $jml_key = array_keys($ex, $ex[$i]);
        if(count($jml_key)>1){
            unset($ex[$i]);
        }

        //$temp = $ex[$i];
    }
    return implode(",", $ex);
}

?>
  