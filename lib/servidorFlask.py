from flask import Flask, jsonify, request
import serial
import time

# Configurações da porta serial
porta_serial = 'COM3'  # Porta serial
baudrate = 9600  # Taxa de transmissão

app = Flask(__name__)

# Inicializa a conexão serial
try:
    arduino = serial.Serial(porta_serial, baudrate, timeout=1)
    time.sleep(2)  # Aguarda o Arduino inicializar
    print(f'Conectado à porta {porta_serial}.')
except serial.SerialException as e:
    print(f'Erro na conexão serial: {e}')
    exit(1)  # Encerra o programa se não conseguir conectar

@app.route('/data', methods=['GET'])
def get_data():
    if arduino.in_waiting > 0:  # Verifica se há dados disponíveis
        dados = arduino.readline().decode('utf-8', errors='ignore').strip()  # Lê uma linha de dados
        return jsonify({'data': dados})
    else:
        return jsonify({'data': dados})

@app.route('/send_data', methods=['POST'])
def send_data():
    # Obtém dados enviados no corpo da requisição
    data = request.json.get('data')
    
    if data:
        # Envia os dados para o Arduino via porta serial
        try:
            arduino.write(data.encode())  # Envia os dados para o Arduino
            return jsonify({'status': 'success', 'message': 'Data sent to Arduino'})
        except Exception as e:
            return jsonify({'status': 'error', 'message': f'Failed to send data: {str(e)}'}), 500
    else:
        return jsonify({'status': 'error', 'message': 'No data provided'}), 400

if __name__ == '__main__':
    try:
        app.run(host='0.0.0.0', port=5000)
    except KeyboardInterrupt:
        print('Programa encerrado.')
    finally:
        if 'arduino' in locals():
            arduino.close()  # Fecha a conexão serial ao encerrar o programa



