module Sensors {

    @ 3-tuple type used for telemetry
    array envTlm = [4] F32

    @ Passive component for Adafruit BME680 Breakout
    passive component BME680 {

        ##############################################################################
        #### Uncomment the following examples to start customizing your component ####
        ##############################################################################

        # ----------------------------------------------------------------------
        # General ports
        # ----------------------------------------------------------------------

        @ Port that reads data from device
        output port read: Drv.I2c

        @ Port that writes data to device
        output port write: Drv.I2c

        # ----------------------------------------------------------------------
        # Special ports
        # ----------------------------------------------------------------------

        @ Port receiving calls from the rate group
        sync input port run: Svc.Sched

        # ----------------------------------------------------------------------
        # Parameters
        # ----------------------------------------------------------------------

        # @ Example parameter
        # param PARAMETER_NAME: U32

        ###############################################################################
        # Standard AC Ports: Required for Channels, Events, Commands, and Parameters  #
        ###############################################################################
        @ Port for requesting the current time
        time get port timeCaller

        @ Port for sending command registrations
        command reg port cmdRegOut

        @ Port for receiving commands
        command recv port cmdIn

        @ Port for sending command responses
        command resp port cmdResponseOut

        @ Port for sending textual representation of events
        text event port logTextOut

        @ Port for sending events to downlink
        event port logOut

        @ Port for sending telemetry channels to downlink
        telemetry port tlmOut

        @ Port to return the value of a parameter
        param get port prmGetOut

        @ Port to set the value of a parameter
        param set port prmSetOut

        # ----------------------------------------------------------------------
        # Events
        # ----------------------------------------------------------------------

        @ Error occurred when requesting telemetry
        event TelemetryError(
            status: Drv.I2cStatus @< the status value returned
        ) \
        severity warning high \
        format "Telemetry request failed with status {}"

        @ Configuration failed
        event SetUpConfigError(
            writeStatus: Drv.I2cStatus @< the status of writing data to device
        ) \
        severity warning high \
        format "Setup Error: Write status failed with code {}"

        @ Device was not taken out of sleep mode
        event PowerModeError(
            writeStatus: Drv.I2cStatus @< the status of writing data to device
        ) \
        severity warning high \
        format "Setup Error: Power mode failed to set up with write code {}"

        @ Report power state
        event PowerStatus(
            powerStatus: Fw.On @< power state of device
        ) \
        severity activity high \
        format "The device has been turned {}"

        # ----------------------------------------------------------------------
        # Commands
        # ----------------------------------------------------------------------

        @ Command to turn on the device
        guarded command PowerSwitch(powerState: Fw.On)

        # ----------------------------------------------------------------------
        # Telemetry
        # ----------------------------------------------------------------------

        @ temperature from temperature sensor
        telemetry temperature: envTlm id 0 update always format "{} C"

        @ pressure from barometer
        telemetry pressure: envTlm id 1 update always format "{} hPa"

        @ humidity from humidity senor
        telemetry humidity: envTlm id 2 update always format "{} %"

        @ voc from gas senor
        telemetry voc: envTlm id 3 update always format "{} omh"

    }
}