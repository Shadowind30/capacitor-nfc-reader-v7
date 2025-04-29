package io.monaca.capacitor.nfcreader;

import android.app.PendingIntent;
import android.content.Intent;
import android.nfc.NfcAdapter;
import android.nfc.Tag;
import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

@CapacitorPlugin(name = "NFCReader")
public class NFCReader extends Plugin {
    private NfcAdapter nfcAdapter;
    private PendingIntent pendingIntent;
    private boolean isScanning = false;

    @Override
    public void load() {
        initializeNfcAdapter();
    }

    private void initializeNfcAdapter() {
        nfcAdapter = NfcAdapter.getDefaultAdapter(getContext());
        if (nfcAdapter != null) {
            pendingIntent = PendingIntent.getActivity(
                getContext(),
                0,
                new Intent(getContext(), getActivity().getClass())
                    .addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP),
                PendingIntent.FLAG_MUTABLE
            );
        }
    }

    @PluginMethod
    public void initialize(PluginCall call) {
        JSObject result = new JSObject();
        if (nfcAdapter == null || !nfcAdapter.isEnabled()) {
            result.put("value", false);
            call.resolve(result);
            return;
        }

        result.put("value", true);
        call.resolve(result);
    }

    @PluginMethod
    public void startScanning(PluginCall call) {
        if (nfcAdapter == null || !nfcAdapter.isEnabled()) {
            call.reject("NFC is not available or disabled");
            return;
        }

        try {
            nfcAdapter.enableForegroundDispatch(getActivity(), pendingIntent, null, null);
            isScanning = true;
            call.resolve();
        } catch (Exception e) {
            call.reject("Failed to start NFC scanning", e);
        }
    }

    @PluginMethod
    public void stopScanning(PluginCall call) {
        if (nfcAdapter == null) {
            call.reject("NFC is not initialized");
            return;
        }

        try {
            if (isScanning) {
                nfcAdapter.disableForegroundDispatch(getActivity());
                isScanning = false;
            }
            call.resolve();
        } catch (Exception e) {
            call.reject("Failed to stop NFC scanning", e);
        }
    }

    @Override
    protected void handleOnNewIntent(Intent intent) {
        super.handleOnNewIntent(intent);
        
        Tag tag = intent.getParcelableExtra(NfcAdapter.EXTRA_TAG);
        if (tag != null) {
            JSObject result = new JSObject();
            result.put("id", bytesToHexString(tag.getId()));
            notifyListeners("nfcTagDetected", result);
        }
    }

    private String bytesToHexString(byte[] bytes) {
        StringBuilder sb = new StringBuilder();
        for (byte b : bytes) {
            sb.append(String.format("%02X", b));
        }
        return sb.toString();
    }
}
