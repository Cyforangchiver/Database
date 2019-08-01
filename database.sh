#!/bin/bash
#     ▇▇▇▇▇
#     ▇▇▇▇▇
#     ▇▇▇▇▇       Enjoy..!
#   ▅▅▇▇▇▇▇▅▅     Thanks Sudah Menggunakan Tools Kami
#   ▕▍╱╲╲╱╱╲      Dan Juga Subscribe Channel youtube :
#   ╭▎▏▍╲╱▍▕          -Ang Lolipop-
#   ┃╯╲＿╱╲
#   ╰╯┊┊╭╰━━━╮    Nick Creator  : Cyforangchiver.
#   ┊┳┳╯╰━━━╮┃    Nick Assisten : Liona Wu.
#   ┊┃┃━╯╰━┊╰╯
#   ┊┃╰┳┳┳┳┛      ////////////////////////////////////
#   ┊╰━┻┻┻┻━╮     \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
#   ┊┊┊┊┊┊┊┊┃
#   ╰━━━━━━━╯

menu(){
  clear
  tput cup 2 8;
  echo "[DATABASE]"
  tput cup 3 11;
  echo "1. Entry  Data"
  tput cup 4 11;
  echo "2. Cari  Data"
  tput cup 5 11;
  echo "3. Cetak Data"
  tput cup 6 11;
  echo "4. Exit"
  tput cup 7 9;
  read -p "Masukkan Pilihan [1-4] :" pil;
  while [ -z $pil ] || [ $pil -lt 1 ] || [ $pil -gt 4 ];
  do
     tput cup 7 9
     read -p "Masukkan Pilihan [1-4] :" pil;
  done

}

entry()
{

  tput cup 9 27
  echo "Enrty data"
  tput cup 11 27
  echo -n "Nama      :";
  read nama;

  while  [ -z $nama ] || grep  $nama $data -q -i;
  do
      tput cup 13 27
      echo "Ops Tidak boleh kosong atau $nama sudah ada";
      sleep 3
      clear
      tput cup 11 27
      echo -n "Nama      :";
      read nama;
  done


  tput cup 12 27
  echo -n "Kota      :";
  read kota;
  tput cup 13 27
  echo -n "Alamat    :";
  read alamat;
  tput cup 14 27
  echo -n "Email     :";
  read email;
  tput cup 16 27
  echo "Rekam data ke file"
  if !(echo $nama:$kota:$alamat:$email>>$data); then
       echo "Ops, gagal merekam ke file"
       exit 1;
  fi
  sleep 3;
}


cari(){
  tput cup 9 27
  echo "Cari data per record"
  tput cup 11 27
  echo -n "Nama         :";
  read nama;
  while [ -z $nama ];
  do
    tput cup 13 27
    echo "Ops, nama tidak boleh kosong"
    sleep 3;
    tput cup 11 27
    echo -n "Nama         :";
    read nama;
  done

      if found=`grep $nama $data -n -i`; then
     tput cup 12 27
     echo -n "Kota         :";
         echo "$found" | cut -d: -f3
         tput cup 13 27
         echo -n "Alamat       :";
         echo "$found" | cut -d: -f4
     tput cup 14 27
         echo -n "Email        :";
         echo "$found" | cut -d: -f5
         tput cup 16 27
         echo -n "Record ke- $found" | cut -d: -f1
      else
         tput cup 13 27
         echo "Ops, data tidak ditemukan";
      fi

}

cetak()
{
  tput cup 12 27
  echo "Tampilkan Data"
  tput cup 13 27
  echo -n "1->Ascendig, 2->Descending :"
  read mode
  clear;
  if [ -z $mode ] || [ $mode -eq 1 ]; then
     cat $data | sort  | more -d
  elif [ $mode -eq 2 ]; then
     cat $data | sort -r | more -d
  else
  cat $data | sort | more -d
  fi
}


#block utama

  data="mydata"

  if !(test -e $data); then
    if !(touch $data); then
       echo "gagal buat file database"
       exit 1
    fi
  fi

  lagi='y'
  while [ $lagi == 'y' ] || [ $lagi == 'Y' ]
  do
  menu;
    case $pil in
       1) entry
          ;;
       2) cari;
          ;;
       3) cetak
          ;;
       4) clear;
          exit 0;
          ;;
       *)
          echo "$pil, tidak ada dalam pilihan"
          ;;
    esac

  tput cup 18 27
  echo -n "Ke Menu (y/t): ";
  read lagi;
  done

  clear
