# @monaca/capacitor-nfc-reader

A Capacitor plugin for reading NFC tags on Android and iOS devices

## Install

```bash
npm install @monaca/capacitor-nfc-reader
npx cap sync
```

## API

<docgen-index>

* [`initialize()`](#initialize)
* [`startScanning()`](#startscanning)
* [`stopScanning()`](#stopscanning)
* [`addListener('nfcTagDetected', ...)`](#addlistenernfctagdetected-)
* [`addListener('nfcError', ...)`](#addlistenernfcerror-)
* [`removeAllListeners()`](#removealllisteners)
* [Interfaces](#interfaces)
* [Enums](#enums)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### initialize()

```typescript
initialize() => Promise<{ value: boolean; }>
```

**Returns:** <code>Promise&lt;{ value: boolean; }&gt;</code>

--------------------


### startScanning()

```typescript
startScanning() => Promise<void>
```

--------------------


### stopScanning()

```typescript
stopScanning() => Promise<void>
```

--------------------


### addListener('nfcTagDetected', ...)

```typescript
addListener(eventName: 'nfcTagDetected', listenerFunc: (tag: NFCTag) => void) => Promise<PluginListenerHandle>
```

| Param              | Type                                                        |
| ------------------ | ----------------------------------------------------------- |
| **`eventName`**    | <code>'nfcTagDetected'</code>                               |
| **`listenerFunc`** | <code>(tag: <a href="#nfctag">NFCTag</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### addListener('nfcError', ...)

```typescript
addListener(eventName: 'nfcError', listenerFunc: (error: NFCError) => void) => Promise<PluginListenerHandle>
```

| Param              | Type                                                              |
| ------------------ | ----------------------------------------------------------------- |
| **`eventName`**    | <code>'nfcError'</code>                                           |
| **`listenerFunc`** | <code>(error: <a href="#nfcerror">NFCError</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### removeAllListeners()

```typescript
removeAllListeners() => Promise<void>
```

--------------------


### Interfaces


#### PluginListenerHandle

| Prop         | Type                                      |
| ------------ | ----------------------------------------- |
| **`remove`** | <code>() =&gt; Promise&lt;void&gt;</code> |


#### NFCTag

| Prop       | Type                                              |
| ---------- | ------------------------------------------------- |
| **`id`**   | <code>string</code>                               |
| **`type`** | <code><a href="#nfctagtype">NFCTagType</a></code> |


#### NFCError

| Prop          | Type                |
| ------------- | ------------------- |
| **`code`**    | <code>string</code> |
| **`message`** | <code>string</code> |


### Enums


#### NFCTagType

| Members        | Value                   |
| -------------- | ----------------------- |
| **`MIFARE`**   | <code>'MIFARE'</code>   |
| **`FeliCa`**   | <code>'FeliCa'</code>   |
| **`ISO15693`** | <code>'ISO15693'</code> |
| **`ISO7816`**  | <code>'ISO7816'</code>  |
| **`Unknown`**  | <code>'Unknown'</code>  |

</docgen-api>
