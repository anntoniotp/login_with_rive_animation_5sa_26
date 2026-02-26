import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import "dart:async"; //3.1 importa del timer

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Cambiado a minúscula para seguir las convenciones de Dart
  bool _obscureText = true; 

// crear el cerebro de la animación
StateMachineController? _controller;
//SMI: State Machine Input
SMIBool? _isChecking;
SMIBool ? _isHandsUp;
SMITrigger? _trigSuccess;
SMITrigger? _trigFail;

//2.1 variable para el recorrido de la mirada
SMINumber? _numLook;

//1.1)crear variables para focus
final _emailFocusNode = FocusNode();
final _passwordFocusNode = FocusNode();

//3.2 timer para detener mirada al dejar de escibir
Timer? _typingDebounce;

//1.2) listeners (oyentes/chismosos)
@override
void initState() {
  super.initState();
  _emailFocusNode.addListener(() {
    if (_emailFocusNode.hasFocus)
    //verifica que no sea nulo
    {
      if (_isHandsUp != null) {

        _isHandsUp!.change(false);
        //2.2 mirada neutral
        _numLook?.value = 50.0;
      }
    }
  });

  _passwordFocusNode.addListener(() {
    _isHandsUp ?.change(_passwordFocusNode.hasFocus);
  });
}
  
  @override
  Widget build(BuildContext context) {
    // Si no usas 'size', puedes borrar esta línea para eliminar el warning
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox (
                width: size.width,
                height: 200,
              child: RiveAnimation.asset(
                "assets/animated_login_bear.riv",
                stateMachines: ["Login Machine"],
                // al iniciar la animación
                onInit: (artboard){
                  _controller = StateMachineController.fromArtboard(artboard, "Login Machine");
                  //verifica que inicio bien la animación
                  if (_controller == null) return;
                    //agrega controlador al tablero/ ecenario de la animación
                    artboard.addController(_controller!);
                    _isChecking = _controller!.findSMI("isChecking") as SMIBool;
                    _isHandsUp = _controller!.findSMI("isHandsUp") as SMIBool;
                    _trigSuccess = _controller!.findSMI("trigSuccess") as SMITrigger;
                    _trigFail = _controller!.findSMI("trigFail") as SMITrigger;
                    //2.3 vincular el num look
                    _numLook = _controller!.findSMI("numLook");
                  }
              )
              
              ),
              
              const SizedBox(height: 10),
              //campo de email 
              TextField(
                //1.3 asignar los focus nodes a cada campo de texto
                focusNode: _emailFocusNode,
                onChanged: (value) {
                  if (_isHandsUp != null) {
                    // baja las manos al escribir el email
                   // _isHandsUp!.change(false);
                  }
                  //si checking no es nulo, activar el modo chismoso
                  if (_isChecking != null) {
                    //activar modo chismoso
                    _isChecking!.change(true);
                    //2.4 mover la mirada del oso al escribir el email
                    //ajustes de limites de 0 a 100
                    //80 como medida de calibracion
                    final look = (value.length/80.0 * 100.0)
                    .clamp(0.0, 100.0); // es el rango de la abrazadera
                    _numLook?.value = look;

                    //3.3 Debounce: si vuelve a teclear, reinicia el contador
                    //cancelar cualquier timer existente 
                    _typingDebounce?.cancel();
                    //crear un nuevo timer
                    _typingDebounce = Timer(
                      const Duration(seconds: 3), 
                      () {
                        //si se cierra la pantalla, quita el timer
                        if (!mounted) return;
                       //mirada neutra

                        _isChecking?.change(false);
                      }
                    ) ; 
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 10),
// campo de texto de contraseña con el ícono de ojo para mostrar/ocultar la contraseña
              TextField(
                //1.3 asignar los focus nodes a cada campo de texto
                focusNode: _passwordFocusNode,
                
                 onChanged: (value) {
                  if (_isHandsUp != null) {
                    //tapes los ojos al ver la contraseña
                    _isHandsUp!.change(true);
                  }
                  if (_isChecking != null) {
                    //no activar el modo chismoso
                    //_isChecking!.change(false);
                  }
                },
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    // Íconos alternados correctamente
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              
              // Añadimos un espacio al final para que no pegue al borde inferior
              SizedBox(height: size.height * 0.05), 
            ],
          ),
        ),
      ),
    );
  }
    //1.4 liberar memoria
    @override
    void dispose() {
      //1.4) eliminar los listeners para evitar fugas de memoria
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
      _typingDebounce ?.cancel(); // cancelar el timer si está activo
      super.dispose();
    }
  }