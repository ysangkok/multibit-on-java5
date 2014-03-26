#!/usr/bin/zsh -e

if [ ! -d jimburton618-bitcoinj-coinbase-tx ]; then
  git clone https://code.google.com/r/jimburton618-bitcoinj-coinbase-tx/
  cd jimburton618-bitcoinj-coinbase-tx/
  git checkout bcj-0.10.3-mb-alice
  #mvn dependency:copy-dependencies
cd ..
fi

if [ ! -d multibit ]; then
  git clone https://github.com/jim618/multibit.git
  cd multibit/
  git checkout 217e5a77
  #mvn dependency:copy-dependencies
  cd ..
fi

rm -rf merged
mkdir merged
cd merged
find ../jimburton618-bitcoinj-coinbase-tx ../multibit -type d -name java -execdir sh -c "readlink -f {}; cp -ri {} $PWD" \;
cd ..

if [ ! -d jars ]; then
mkdir jars
cd jars
#find ~/.m2 -name '*.jar' -execdir ln {} $PWD \;
wget --no-clobber --content-disposition \
 "http://search.maven.org/remotecontent?filepath=commons-codec/commons-codec/1.6/commons-codec-1.6.jar"\
 "http://search.maven.org/remotecontent?filepath=com/google/code/gson/gson/2.2.4/gson-2.2.4.jar"\
 "http://search.maven.org/remotecontent?filepath=com/google/guava/guava-jdk5/16.0/guava-jdk5-16.0.jar"\
 "http://search.maven.org/remotecontent?filepath=com/fasterxml/jackson/core/jackson-core/2.1.5/jackson-core-2.1.5.jar"\
 "http://search.maven.org/remotecontent?filepath=com/fasterxml/jackson/core/jackson-annotations/2.1.5/jackson-annotations-2.1.5.jar"\
 "http://search.maven.org/remotecontent?filepath=com/fasterxml/jackson/core/jackson-databind/2.1.5/jackson-databind-2.1.5.jar"\
 "http://search.maven.org/remotecontent?filepath=net/jcip/jcip-annotations/1.0/jcip-annotations-1.0.jar"\
 "http://search.maven.org/remotecontent?filepath=com/googlecode/jcsv/jcsv/1.4.0/jcsv-1.4.0.jar"\
 "http://search.maven.org/remotecontent?filepath=joda-time/joda-time/2.3/joda-time-2.3.jar"\
 "http://search.maven.org/remotecontent?filepath=com/google/code/findbugs/jsr305/2.0.3/jsr305-2.0.3.jar"\
 "http://search.maven.org/remotecontent?filepath=javax/ws/rs/jsr311-api/1.1.1/jsr311-api-1.1.1.jar"\
 "http://search.maven.org/remotecontent?filepath=org/simplericity/macify/macify/1.6/macify-1.6.jar"\
 "http://search.maven.org/remotecontent?filepath=io/netty/netty/3.9.0.Final/netty-3.9.0.Final.jar"\
 "http://search.maven.org/remotecontent?filepath=com/google/protobuf/protobuf-java/2.5.0/protobuf-java-2.5.0.jar"\
 "http://search.maven.org/remotecontent?filepath=com/github/mmazi/rescu/1.5.0/rescu-1.5.0.jar"\
 "http://search.maven.org/remotecontent?filepath=org/slf4j/slf4j-api/1.7.6/slf4j-api-1.7.6.jar"\
 "http://search.maven.org/remotecontent?filepath=com/madgag/sc-light-jdk15on/1.47.0.3/sc-light-jdk15on-1.47.0.3.jar"\
 "http://mvn-adamgent.googlecode.com/svn/maven/release/com/google/zxing/core/1.6/core-1.6.jar"\
 "http://mvn-adamgent.googlecode.com/svn/maven/release/com/google/zxing/javase/1.6/javase-1.6.jar"\
 "http://search.maven.org/remotecontent?filepath=junit/junit/4.11/junit-4.11.jar"\
 "http://search.maven.org/remotecontent?filepath=org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar"\
 "http://search.maven.org/remotecontent?filepath=org/easymock/easymock/3.2/easymock-3.2.jar"\
 "http://search.maven.org/remotecontent?filepath=net/sf/jopt-simple/jopt-simple/4.6/jopt-simple-4.6.jar"\
 "http://search.maven.org/remotecontent?filepath=org/codehaus/jackson/jackson-mapper-asl/1.9.13/jackson-mapper-asl-1.9.13.jar"\
 "http://search.maven.org/remotecontent?filepath=org/codehaus/jackson/jackson-core-asl/1.9.13/jackson-core-asl-1.9.13.jar"\
 "http://search.maven.org/remotecontent?filepath=backport-util-concurrent/backport-util-concurrent/3.1/backport-util-concurrent-3.1.jar"
cd ..
fi

cd merged

#wget "https://github.com/pholser/jopt-simple/archive/master.zip"
#unzip master.zip
#cp -rl jopt-simple-master/src/* java/

git clone https://github.com/wg/scrypt.git
cd scrypt
git checkout 06752363
cd ..
cp -rl scrypt/src/main/java/* java/

git clone https://github.com/JodaOrg/joda-money.git
cd joda-money
git checkout e7c2557c5fd12104bf61a1d6c7e121e8936e782f
cd ..
cp -rl joda-money/src/main/java/* java/

git clone https://github.com/JodaOrg/joda-convert.git
cd joda-convert
git checkout 309d2e17798a408d53f6b317bfa61434d40ef412
cd ..
cp -rl joda-convert/src/main/java/* java/
rm java/org/joda/convert/JDKStringConverter.java

git clone https://github.com/timmolter/XChange.git
cd XChange
git checkout master
cd ..

cp -rl XChange/xchange-core/src/main/java/* java/
cp -rl XChange/xchange-{bitstamp,btce,campbx,openexchangerates,cavirtex}/src/main/java/* java/
#sed -ire 's/com.xeiam.xchange.btce.BTCEExchange/com.xeiam.xchange.btce.v2.BTCEExchange/' java/org/multibit/model/exchange/ExchangeData.java

git clone https://github.com/pusher/pusher-java-client.git
cd pusher-java-client
git checkout ca36169b
cd ..
cp -rl pusher-java-client/src/main/java/* java/

git clone https://github.com/TooTallNate/Java-WebSocket.git
cd Java-WebSocket
git checkout 7c3b2235
cd ..
cp -rl Java-WebSocket/src/main/java/* java/

mkdir -p java/java/io/
wget -O java/java/io/Console.java "http://grepcode.com/file_/repository.grepcode.com/java/root/jdk/openjdk/7u40-b43/java/io/Console.java/?v=source"

svn co https://svn.java.net/svn/swingworker~svn/trunk swingworker
perl -pi -e 's/javax.swing.SwingWorker/org.jdesktop.swingworker.SwingWorker/g' java/**/*.java
cp -rl swingworker/src/java/* java/

git clone https://github.com/timmolter/XChart.git
cd XChart
git checkout f38ed5b633c3b9d2634556c2447c992ba201275f
cd ..
cp -rl XChart/xchart/src/main/java/* java/

dos2unix java/**/*.java

for i in ABOVE_BASELINE_TRAILING ABOVE_BASELINE_LEADING ABOVE_BASELINE BASELINE_LEADING BASELINE_TRAILING BELOW_BASELINE_LEADING BELOW_BASELINE_TRAILING BELOW_BASELINE BASELINE BELOW_CENTER
  do perl -pi -e "s/\b$i\b/CENTER/g" java/**/*.java
done
perl -pi -e 's/new *PropertyResourceBundle *\(new *InputStreamReader *\( *inputStream *, *"UTF8" *\)\)/new PropertyResourceBundle(inputStream)/g' java/**/*.java
#perl -pi -e 's/ +(!?) *([A-z]+).isEmpty\(\)/ (\1\2.equals("") || \2 instanceof java.util.Collection && \1((java.util.Collection) \2).isEmpty())/g' java/**/*.java
perl -pi -e 's/isEmpty\(/equals(""/g' java/org/java_websocket/drafts/Draft_76.java java/org/multibit/viewsystem/swing/action/Validator.java java/org/multibit/viewsystem/swing/MultiBitFrame.java java/org/multibit/viewsystem/swing/view/ImageSelection.java
perl -pi -e 's/userPreferences\.store\(outputStreamWriter/userPreferences.store(bufferedOutputStream/g' java/**/*.java
perl -pi -e 's/userPreferences\.load\(inputStreamReader/userPreferences.load(inputStream/g' java/**/*.java
perl -pi -e 's/([A-z]+)\.convertRowIndexTo(View|Model)\(([A-z]+)\)/\3/g' java/**/*.java
perl -pi -e 's/Font\.(SANS_SERIF|DIALOG)/"Sans Serif"/g' java/**/*.java
perl -pi -e 's/java\.util\.concurrent/edu.emory.mathcs.backport.java.util.concurrent/g' java/com/xeiam/xchart/internal/chartpart/DateFormatter.java
perl -pi -e 's/Arrays.copy/com.google.bitcoin.core.Utils.copy/g' java/**/*.java 
perl -pi -e 's/([A-z]+)\.getBytes\(Charsets\.UTF_8\)/com.google.bitcoin.core.Utils.getBytesUTF8Bytes(\1)/g' java/**/*.java
perl -pi -e 's/Charset\.forName\((".*")\)/\1/g' java/**/*.java
perl -pi -e 's/pollLast/removeLast/g' java/**/*.java
perl -pi -e 's/pollFirst/removeFirst/g' java/**/*.java
perl -pi -e 's/\.push\(/.addFirst(/g' java/**/*.java
perl -pi -e 's/System\.console/new java.io.Console/g' java/**/*.java
sed -i '/allowCoreThreadTimeOut/d' java/**/*.java
sed -i '/setWritable/d' java/**/*.java
sed -i '/setAutoCreateRowSorter/d' java/**/*.java
sed -i '/setRowSorter/d' java/**/*.java
sed -i '/setIconImage/d' java/**/*.java
sed -i 's/throw new IOException(e);/throw new IOException(e.getMessage());/g' java/**/*.java
perl -pi -e 's/([A-z]+)\.descendingIterator\(\)/com.google.common.collect.Lists.reverse(\1).iterator()/g' java/**/*.java
cat << END > java/org/multibit/viewsystem/swing/view/panels/TableRowSorter.java
package org.multibit.viewsystem.swing.view.panels;
import java.util.*;
import javax.swing.*;
import javax.swing.table.*;

public class TableRowSorter<M extends TableModel> {
    TableRowSorter() {
    }

    TableRowSorter(M model) {
    }

    Comparator<?> getComparator(int column) {
        return null;
    }

    void setSortKeys(List<SortKey> l) {
    }

    void setComparator(int idx, Comparator c) {
    }

    int convertRowIndexToModel(int idx) {
        return idx;
    }

    static class SortKey {
        SortKey(int a, SortOrder b) {
        }
    }
}
END

cat << END > java/org/multibit/viewsystem/swing/view/panels/SortOrder.java
package org.multibit.viewsystem.swing.view.panels;
public enum SortOrder {
        ASCENDING, DESCENDING, UNSORTED;
}
END

patch java/org/multibit/network/ReplayManager.java << END
18a19
> import org.jdesktop.swingworker.SwingWorker;
END

patch java/org/multibit/viewsystem/swing/view/panels/ShowPreferencesPanel.java << END
1657,1667c1657
<         if (!java.awt.Desktop.isDesktopSupported()) {
<             return false;
<         }
< 
<         java.awt.Desktop desktop = java.awt.Desktop.getDesktop();
< 
<         if (!desktop.isSupported(java.awt.Desktop.Action.BROWSE)) {
<             return false;
<         }
< 
<         return true;
---
>         return false;
1671,1678d1660
<         try {
<             java.awt.Desktop desktop = java.awt.Desktop.getDesktop();
<             desktop.browse(uri);
<         } catch (IOException ioe) {
<             log.debug(ioe.getMessage());
<             Message message = new Message("Cannot display URL '" + uri.toString() + "'. Error was '" + ioe.getMessage() + "'");
<             MessageManager.INSTANCE.addMessage(message);
<         }
END

patch java/org/multibit/network/AlertManager.java << END
345,355c345
<         if (!java.awt.Desktop.isDesktopSupported()) {
<             return false;
<         }
< 
<         java.awt.Desktop desktop = java.awt.Desktop.getDesktop();
< 
<         if (!desktop.isSupported(java.awt.Desktop.Action.BROWSE)) {
<             return false;
<         }
< 
<         return true;
---
>         return false;
359,367d348
<         try {
<             java.awt.Desktop desktop = java.awt.Desktop.getDesktop();
<             desktop.browse(uri);
<         } catch (IOException ioe) {
<             log.debug(ioe.getMessage());
<             Message message = new Message(controller.getLocaliser().getString("browser.unableToLoad",
<                     new String[] { uri.toString(), ioe.getMessage() }));
<             MessageManager.INSTANCE.addMessage(message);
<         }
END

patch java/com/google/bitcoin/utils/Threading.java << END
20d19
< import com.google.common.util.concurrent.CycleDetectingLockFactory;
90d88
<         throwOnLockCycles();
110,112d107
<     private static CycleDetectingLockFactory.Policy policy;
<     public static CycleDetectingLockFactory factory;
< 
114,135c109
<         return factory.newReentrantLock(name);
<     }
< 
<     public static void warnOnLockCycles() {
<         setPolicy(CycleDetectingLockFactory.Policies.WARN);
<     }
< 
<     public static void throwOnLockCycles() {
<         setPolicy(CycleDetectingLockFactory.Policies.THROW);
<     }
< 
<     public static void ignoreLockCycles() {
<         setPolicy(CycleDetectingLockFactory.Policies.DISABLED);
<     }
< 
<     public static void setPolicy(CycleDetectingLockFactory.Policy policy) {
<         Threading.policy = policy;
<         factory = CycleDetectingLockFactory.newInstance(policy);
<     }
< 
<     public static CycleDetectingLockFactory.Policy getPolicy() {
<         return policy;
---
>         return new ReentrantLock();
END

patch java/com/google/bitcoin/core/ECKey.java << END
569c569,573
<         return new String(Base64.encode(sigData), "UTF-8");
---
>         try {
>             return new String(Base64.encode(sigData), "UTF-8");
>         } catch (Exception e) {
>             throw new RuntimeException(e);
>         }
END

patch java/com/google/bitcoin/core/CheckpointManager.java << END
125,126c125,126
<             Map.Entry<Long, StoredBlock> entry = checkpoints.floorEntry(time);
<             if (entry != null) return entry.getValue();
---
>             StoredBlock entry = checkpoints.get(time == Long.MAX_VALUE ? checkpoints.lastKey() : checkpoints.subMap(Long.MIN_VALUE, time+1).lastKey());
>             if (entry != null) return entry;
END

patch java/java/io/Console.java << END
91a92
> class IOError extends RuntimeException {IOError(Exception e) {super(e);}}
306,336c307
<         char[] passwd = null;
<         synchronized (writeLock) {
<             synchronized(readLock) {
<                 try {
<                     echoOff = echo(false);
<                 } catch (IOException x) {
<                     throw new IOError(x);
<                 }
<                 IOError ioe = null;
<                 try {
<                     if (fmt.length() != 0)
<                         pw.format(fmt, args);
<                     passwd = readline(true);
<                 } catch (IOException x) {
<                     ioe = new IOError(x);
<                 } finally {
<                     try {
<                         echoOff = echo(true);
<                     } catch (IOException x) {
<                         if (ioe == null)
<                             ioe = new IOError(x);
<                         else
<                             ioe.addSuppressed(x);
<                     }
<                     if (ioe != null)
<                         throw ioe;
<                 }
<                 pw.println();
<             }
<         }
<         return passwd;
---
>         return readLine(fmt, args).toCharArray();
514,552d484
<     // Set up JavaIOAccess in SharedSecrets
<     static {
<         try {
<             // Add a shutdown hook to restore console's echo state should
<             // it be necessary.
<             sun.misc.SharedSecrets.getJavaLangAccess()
<                 .registerShutdownHook(0 /* shutdown hook invocation order */,
<                     false /* only register if shutdown is not in progress */,
<                     new Runnable() {
<                         public void run() {
<                             try {
<                                 if (echoOff) {
<                                     echo(true);
<                                 }
<                             } catch (IOException x) { }
<                         }
<                     });
<         } catch (IllegalStateException e) {
<             // shutdown is already in progress and console is first used
<             // by a shutdown hook
<         }
< 
<         sun.misc.SharedSecrets.setJavaIOAccess(new sun.misc.JavaIOAccess() {
<             public Console console() {
<                 if (istty()) {
<                     if (cons == null)
<                         cons = new Console();
<                     return cons;
<                 }
<                 return null;
<             }
< 
<             public Charset charset() {
<                 // This method is called in sun.security.util.Password,
<                 // cons already exists when this method is called
<                 return cons.cs;
<             }
<         });
<     }
555c487
<     private Console() {
---
>     public Console() {
END

patch java/org/joda/convert/StringConvert.java << END
142,152d141
<             for (JDKStringConverter conv : JDKStringConverter.values()) {
<                 registered.put(conv.getType(), conv);
<             }
<             registered.put(Boolean.TYPE, JDKStringConverter.BOOLEAN);
<             registered.put(Byte.TYPE, JDKStringConverter.BYTE);
<             registered.put(Short.TYPE, JDKStringConverter.SHORT);
<             registered.put(Integer.TYPE, JDKStringConverter.INTEGER);
<             registered.put(Long.TYPE, JDKStringConverter.LONG);
<             registered.put(Float.TYPE, JDKStringConverter.FLOAT);
<             registered.put(Double.TYPE, JDKStringConverter.DOUBLE);
<             registered.put(Character.TYPE, JDKStringConverter.CHARACTER);
END

patch java/org/multibit/viewsystem/swing/MultiBitTabbedPane.java << END
93c93
<             Component tabComponent = getTabComponentAt(index);
---
>             Component tabComponent = getSelectedComponent();
215c215
<         addTab(null, component);    
---
>         addTab(title, component);    
219,220d218
<         ToolTipManager.sharedInstance().unregisterComponent(tab);
<         setTabComponentAt(getTabCount() - 1, tab);
END

patch java/com/google/bitcoin/core/Utils.java << END
541a542,581
>     public static byte[] getBytesUTF8Bytes(String a) {try {return a.getBytes("UTF-8");} catch (Exception e) {throw new RuntimeException(e);}}
>     public static <T> T[] copyOfRange(T[] original, int from, int to) {
>         return copyOfRange(original, from, to, (Class<T[]>) original.getClass());
>     }
> 
>     public static <T,U> T[] copyOfRange(U[] original, int from, int to, Class<? extends T[]> newType) {
>         int newLength = to - from;
>         if (newLength < 0)
>             throw new IllegalArgumentException(from + " > " + to);
>         T[] copy = ((Object)newType == (Object)Object[].class)
>             ? (T[]) new Object[newLength]
>             : (T[]) java.lang.reflect.Array.newInstance(newType.getComponentType(), newLength);
>         System.arraycopy(original, from, copy, 0,
>                          Math.min(original.length - from, newLength));
>         return copy;
>     }
> 
>     public static byte[] copyOfRange(byte[] original, int from, int to) {
>         int newLength = to - from;
>         if (newLength < 0)
>             throw new IllegalArgumentException(from + " > " + to);
>         byte[] copy = new byte[newLength];
>         System.arraycopy(original, from, copy, 0,
>                          Math.min(original.length - from, newLength));
>         return copy;
>     }
> 
>     public static <T> T[] copyOf(T[] original, int newLength) {
>         return (T[]) copyOf(original, newLength, original.getClass());
>     }
> 
>     public static <T,U> T[] copyOf(U[] original, int newLength, Class<? extends T[]> newType) {
>         T[] copy = ((Object)newType == (Object)Object[].class)
>             ? (T[]) new Object[newLength]
>             : (T[]) java.lang.reflect.Array.newInstance(newType.getComponentType(), newLength);
>         System.arraycopy(original, 0, copy, 0,
>                          Math.min(original.length, newLength));
>         return copy;
>     }
> 
END

patch java/org/multibit/viewsystem/swing/view/dialogs/TransactionDetailsDialog.java << END
608,618c608
<         if (!java.awt.Desktop.isDesktopSupported()) {
<             return false;
<         }
< 
<         java.awt.Desktop desktop = java.awt.Desktop.getDesktop();
< 
<         if (!desktop.isSupported(java.awt.Desktop.Action.BROWSE)) {
<             return false;
<         }
< 
<         return true;
---
>         return false;
622,629d611
<         try {
<             java.awt.Desktop desktop = java.awt.Desktop.getDesktop();
<             desktop.browse(uri);
<         } catch (IOException ioe) {
<             log.debug(ioe.getMessage());
<             Message message = new Message(controller.getLocaliser().getString("browser.unableToLoad", new String[]{ uri.toString(), ioe.getMessage()}));
<             MessageManager.INSTANCE.addMessage(message);
<         }
END

patch java/org/multibit/ApplicationDataDirectoryLocator.java << END
81c81
<                 applicationDataDirectory = System.getenv("APPDATA") + File.separator + "MultiBit";
---
>                 applicationDataDirectory = (System.getenv("APPDATA") != null ? System.getenv("APPDATA") : javax.swing.filechooser.FileSystemView.getFileSystemView().getHomeDirectory().getPath()) + File.separator + "MultiBit";
END

for i in CreateNewReceivingAddressSubmit OpenWallet ResetTransactionsSubmit
do patch java/org/multibit/viewsystem/swing/action/${i}Action.java << END
17a18
> import org.jdesktop.swingworker.SwingWorker;
END
done

rm -rf java/com/google/bitcoin/examples
#find java -name '*Tests.java' -delete
find java -name '*Test.java' -delete

ln -s ../jars jars

cd java
#rm -rf test
rm -rf META-INF
cp -rl ../../multibit/src/main/resources/* . || true
cp -rl ../joda-money/src/main/resources/* . || true

javac -bootclasspath /home/janus/Downloads/jdk1.5.0_22/jre/lib/jsse.jar:/home/janus/Downloads/jdk1.5.0_22/jre/lib/rt.jar:/home/janus/Downloads/jdk1.5.0_22/jre/lib/jce.jar:/home/janus/Downloads/jdk1.5.0_22/jre/lib/  -source 1.5 -target 1.5 -encoding ISO-8859-1 -Xmaxerrs 3 -cp "../../jars/*" **/*.java
jar cf ../multibit-jdk5.jar *
cd ..

echo -n '"C:\\Program Files\\Java\\jdk1.5.0_22\\jre\\bin\\java"' -cp "$(echo $(for i in jars/*; do if [[ $i != *junit* && $i != *hamcrest* && $i != *easymock* && $i != *jcip-annotations* && $i != *jackson-annotations* && $i != *jsr311-api* ]]; then echo $i; fi; done) | tr ' ' ';');multibit-jdk5.jar" org.multibit.MultiBit > windows.bat

echo /home/janus/Downloads/jdk1.5.0_22/jre/bin/java -cp "$(echo $(for i in ../jars/*; do if [[ $i != *junit* && $i != *hamcrest* && $i != *easymock* && $i != *jcip-annotations* && $i != *jackson-annotations* && $i != *jsr311-api* ]]; then echo $i; fi; done) | tr ' ' ':'):multibit-jdk5.jar" org.multibit.MultiBit > unix.sh

#cat > Manifest.mf << END
#Main-Class: org.multibit.MultiBit
#Class-Path:$(for i in jars/*; do if [[ $i != *junit* && $i != *hamcrest* && $i != *easymock* && $i != *jcip-annotations* && $i != *jackson-annotations* && $i != *jsr311-api* ]]; then echo $i; fi; done | sed -re 's/^/ /')
#END
