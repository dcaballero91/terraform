pipeline {
    agent any
    
    parameters {
        choice(name: 'vcenter', choices: ['vsphere8', 'vsphere7'], description: 'Selecciona el vCenter: Selecciona el vCenter al que deseas conectar')
    }
    
    stages {
        stage('Configuración') {
            steps {
                script {
                    def vcenterName = params.vcenter.toLowerCase()
                    
                    if (vcenterName == 'vsphere8') {
                        def valorSql = input(message: 'Introduce el valor SQL:', parameters: [string(name: 'valorSql', defaultValue: '')])
                        echo "Valor SQL: ${valorSql}"
                        def maquinaVirtual = input(message: 'Selecciona la configuración de la máquina virtual:', parameters: [choice(name: 'configMaquina', choices: ['pequeño', 'mediano'], description: 'Selecciona el tamaño de la máquina virtual: pequeño (1 CPU) o mediano (2 CPU)')])
                        echo "Configuración de la máquina virtual: ${maquinaVirtual}"
                        def tarjetaRed = input(message: 'Selecciona la tarjeta de red:', parameters: [choice(name: 'tarjetaRed', choices: ['desa', 'prod'], description: 'Selecciona el tipo de tarjeta de red: desa o prod')])
                        echo "Tarjeta de red: ${tarjetaRed}"
                        sh "terraform apply -var 'valor_sql=${valorSql}' -var 'config_maquina=${maquinaVirtual}' -var 'tarjeta_red=${tarjetaRed}'"
                    } else if (vcenterName == 'vsphere7') {
                        def valorLinux = input(message: 'Introduce el valor Linux:', parameters: [string(name: 'valorLinux', defaultValue: '')])
                        echo "Valor Linux: ${valorLinux}"
                        def maquinaVirtual = input(message: 'Selecciona la configuración de la máquina virtual:', parameters: [choice(name: 'configMaquina', choices: ['pequeño', 'mediano'], description: 'Selecciona el tamaño de la máquina virtual: pequeño (1 CPU) o mediano (2 CPU)')])
                        echo "Configuración de la máquina virtual: ${maquinaVirtual}"
                        def tarjetaRed = input(message: 'Selecciona la tarjeta de red:', parameters: [choice(name: 'tarjetaRed', choices: ['desa', 'prod'], description: 'Selecciona el tipo de tarjeta de red: desa o prod')])
                        echo "Tarjeta de red: ${tarjetaRed}"
                        sh "terraform apply -var 'valor_linux=${valorLinux}' -var 'config_maquina=${maquinaVirtual}' -var 'tarjeta_red=${tarjetaRed}'"
                    } else {
                        error "vCenter no válido. Selecciona 'vsphere8' o 'vsphere7'."
                    }
                }
            }
        }
    }
}
