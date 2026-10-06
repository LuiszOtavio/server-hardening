#!/bin/bash
# 1. Atualizar o sistema (apt update + upgrade)
# 2. Instalar ufw e fail2ban se não estiverem instalados
# 3. Configurar ufw — liberar 22 e 80, ativar
# 4. Garantir que fail2ban está rodando e habilitado no boot
# 5. Imprimir relatório final do que foi feito

update_system(){
    sudo apt update -y
    sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
    install_programs
}

install_programs(){
    sudo apt install ufw -y
    sudo apt install fail2ban -y
    config_ufw_fail2ban
}

config_ufw_fail2ban(){
    sudo ufw allow 22
    sudo ufw allow 80
    sudo ufw --force enable

    sudo systemctl enable fail2ban
    sudo systemctl start fail2ban
}

log_message(){
    echo "O firewall no ambiente foi ativado. No momento estão liberadas as portas 80 e 22"
    sudo ufw status
    sudo fail2ban-client status
}

update_system
log_message