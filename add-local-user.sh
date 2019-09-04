#!/bin/bash

# Programın root tarafından çalıştırıldığının kontrolü
if [[ "${UID}" != 0 ]]
then
	echo "Root yetkisi gereklidir."
	exit 1
fi
# Kullanıcının bilgilerini isteme
read -p 'Kullanıcı adını giriniz: ' USERNAME

# Kullanıcının ismini isteme
read -p 'Hesabı kullanacak kişinin ismini giriniz: ' COMMENT

# Kullanıcının şifresini isteme
read -p 'Kullanıcının şifresini isteme: ' PASSWORD

# Kullanıcının oluşturulması
useradd -c "${COMMENT}" -m "${USERNAME}"

# Hata kontrolü
if [[ "${?}" != 0 ]]
then
	echo 'Bir sebeple hata oluştu.'
	exit 1
fi

#Parolanın oluşturulması
echo "${USERNAME}:${PASSWORD}" | chpasswd

#İlk aşamada parola değiştirilmesi
passwd -e ${USERNAME}

#Kullanıcı bilgilerinin gösterilmesi
echo "Username: ${USERNAME}"
echo "Parola: ${PASSWORD}"
echo "Kullanıcı ismi: ${COMMENT}"
echo "Host ismi: ${HOSTNAME}"

