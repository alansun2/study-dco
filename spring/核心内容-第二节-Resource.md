## 2. Resources
本章介绍Spring如何处理资源以及如何在Spring中使用资源。它包括以下主题：

* 介绍
* `Resource`接口
* [内置Resource实现类]（https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#resources-implementations）
* [ `ResourceLoader`](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#resources-resourceloader)
* [`ResourceLoaderAware`接口](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#resources-resourceloaderaware)
* [Resources作为依赖](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#resources-as-dependencies)
* [应用程序上下文和资源路径](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#resources-app-ctx)

### 2.1 介绍
遗憾的是，Java的标准`java.net.URL`类和各种URL前缀的标准处理程序不足以完全访问低级资源。例如，没有标准化的URL实现可用于访问需要从类路径或相对于`ServletContext`获取的资源。
虽然可以为专用的URL前缀注册新的处理程序（类似于http :)这样的前缀的现有处理程序，但这通常非常复杂，并且URL接口仍然缺少一些理想的功能，例如检查资源是否存在。

### 2.2 `Resource`接口
Spring的`Resource`接口旨在成为一个更有能力的接口，用于抽象对低级资源的访问。以下清单显示了`Resource`接口定义：
```
public interface Resource extends InputStreamSource {

    boolean exists();

    boolean isOpen();

    URL getURL() throws IOException;

    File getFile() throws IOException;

    Resource createRelative(String relativePath) throws IOException;

    String getFilename();

    String getDescription();

}
```

正如`Resource`接口的定义所示，它继承了`InputStreamSource`接口。以下清单显示了`InputStreamSource`接口的定义：
```
public interface InputStreamSource {

    InputStream getInputStream() throws IOException;

}
```
`Resource`接口中一些最重要的方法是：

* `getImputStream`： 找到并打开资源，返回一个`InputStream`以从资源中读取。预计每次调用都会返回一个新的`InputStream`。调用者有责任关闭流。、
* `exists()`：返回一个布尔值，指示此资源是否实际以物理形式存在。
* `isOpen()`：返回一个布尔值，指示此资源是否表示具有开放流的句柄。如果为true，则无法多次读取`InputStream`，并且必须仅读取一次然后关闭以避免资源泄漏。对于所有常规资源实现，返回false，但`InputStreamResource`除外。
* `getDescription()`：返回此资源的描述，用于处理资源时的错误输出。这通常是完全限定的文件名或资源的实际URL。

其他方法允许您获取表示资源的实际`URL`或`File`对象（如果底层实现兼容并支持该功能）。当需要资源时，Spring本身广泛使用`Resource`抽象，作为许多方法签名中的参数类型。
某些Spring API中的其他方法（例如各种`ApplicationContext`实现的构造函数）采用一个字符串，该字符串以简单或简单的形式用于创建适合该上下文实现的资源，或者通过String路径上的特殊前缀，让调用者指定必须创建和使用特定的`Resource`实现。

虽然在Spring和Spring中使用了`Resource`接口，但在自己的代码中使用它作为通用实用程序类非常有用，用于访问资源，即使你的代码不知道或不关心任何Spring的其他部分。
虽然这会将您的代码耦合到Spring，但它实际上只将它耦合到这一小组实用程序类中，这些实用程序类可以作为URL的更有能力的替代品，并且可以被认为等同于您将用于此目的的任何其他库

> 资源抽象不会取代功能。它尽可能地包裹它。例如，`UrlResource`包装URL并使用包装的URL来完成其工作。

### 2.3 内置Resource实现类
Spring包括以下`Resource`实现：

* `UrlResource`

* `ClassPathResource`
 
* `FileSystemResource`
 
* `ServletContextResource`
 
* `InputStreamResource`
 
* `ByteArrayResource`

#### 2.3.1 `UrlResource`
`UrlResource`包装`java.net.URL`，可用于访问通常可通过URL访问的任何对象，例如文件，HTTP目标，FTP目标等。
所有URL都具有标准化的字符串表示，以便使用适当的标准化前缀来指示另一个URL类型。这包括`file:`用于访问文件系统路径，`http:`用于通过HTTP协议访问资源，`ftp:`用于通过FTP访问资源，以及其他。

`UrlResource`由Java代码通过显式使用`UrlResource`构造函数创建，但通常在调用采用String参数表示路径的API方法时隐式创建。对于后一种情况，JavaBeans `PropertyEditor`最终决定要创建哪种类型的`Resource`。
如果路径字符串包含众所周知的（对于它）前缀（例如`classpath:`)，则会为该前缀创建适当的专用资源。但是，如果它无法识别前缀，则假定该字符串是标准URL字符串并创建`UrlResource`。

#### 2.3.2 `ClassPathResource`
此类表示应从类路径获取的资源。它使用线程上下文类加载器，给定的类加载器或给定的类来加载资源。

如果类路径资源驻留在文件系统中，而不是驻留在jar中且尚未（通过servlet引擎或任何环境）扩展到文件系统的类路径资源，则此Resource实现支持解析为`java.io.File` 。为了解决这个问题，各种`Resource`实现始终支持作为java.net.URL的解析。

`ClassPathResource`是由Java代码通过显式使用`ClassPathResource`构造函数创建的，但通常在调用采用`String`参数表示路径的API方法时隐式创建。
对于后一种情况，JavaBeans `PropertyEditor`在字符串路径上识别特殊前缀`classpath：`，并在此情况下创建`ClassPathResource`。

#### 2.3.3 `FileSystemResource`
这是`java.io.File`和`java.nio.file.Path`句柄的Resource实现。它支持作为文件和URL的解析。

#### 2.3.4 `ServletContextResource`
这是`ServletContext`资源的`Resource`实现，它解释相关Web应用程序根目录中的相对路径。它始终支持流访问和URL访问，但只有在扩展Web应用程序存档且资源实际位于文件系统上时才允许`java.io.File`访问。
无论它是在文件系统上扩展还是直接从JAR或其他地方（如数据库）（可以想象）访问，实际上都依赖于Servlet容器。

#### 2.3.5 `InputStreamResource`
`InputStreamResource`是给定`InputStream`的`Resource`实现。仅在没有适用的特定资源实现时才应使用它。特别是，在可能的情况下，尽可能使用`ByteArrayResource`或任何基于文件的资源实现。

与其他Resource实现相比，这是已打开资源的描述符。因此，`isOpen()`返回true。如果需要将资源描述符保留在某处或者需要多次读取流，请不要使用它。

#### 2.3.6 `ByteArrayResource`
这是给定字节数组的`Resource`实现。它为给定的字节数组创建一个ByteArrayInputStream。

它对于从任何给定的字节数组加载内容非常有用，而无需求助于单次使用的`InputStreamResource`。

### 2.4 `ResourceLoader`
`ResourceLoader`接口旨在由可以返回（即加载）`Resource`实例的对象实现。以下清单显示了`ResourceLoader`接口定义：
```
public interface ResourceLoader {

    Resource getResource(String location);

}
```
所有应用程序上下文都实现`ResourceLoader`接口。因此，可以使用所有应用程序上下文来获取`Resource`实例。

在特定应用程序上下文上调用`getResource()`并且指定的位置路径没有特定前缀时，将返回适合该特定应用程序上下文的`Resource`类型。
例如，假设针对`ClassPathXmlApplicationContext`实例执行了以下代码片段：
```
Resource template = ctx.getResource("some/resource/path/myTemplate.txt");
```
针对`ClassPathXmlApplicationContext`，该代码返回`ClassPathResource`。如果对`FileSystemXmlApplicationContext`实例执行相同的方法，它将返回`FileSystemResource`。
对于`WebApplicationContext`，它将返回`ServletContextResource`。它同样会为每个上下文返回适当的对象。

因此，您可以以适合特定应用程序上下文的方式加载资源。

另一方面，您也可以通过指定特殊的`classpath:`前缀来强制使用`ClassPathResource`，而不管应用程序上下文类型如何，如下例所示：
```
Resource template = ctx.getResource("classpath:some/resource/path/myTemplate.txt");
```

同样，您可以通过指定任何标准`java.net.URL`前缀来强制使用`UrlResource`。以下一对示例使用`file`和`http`前缀：
```
Resource template = ctx.getResource("file:///some/resource/path/myTemplate.txt");
```
```
Resource template = ctx.getResource("https://myhost.com/resource/path/myTemplate.txt");
```

下表总结了将`String`对象转换为`Resource`对象的策略:

*Table 10. Resource strings*

Prefix | Example | Explanation
:- |:- | :-
classpath: | classpath:com/myapp/config.xml | 从类路径加载。
file: | file:///data/config.xml | 从文件系统加载为URL。另请参见[FileSystemResource Caveats](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#resources-filesystemresource-caveats)。
http: | https://myserver/logo.png | 加载为URL
(none) | /data/config.xml | 取决于底层的ApplicationContext。

####2.5 `ResourceLoaderAware`接口
`ResourceLoaderAware`接口是一个特殊的回调接口，用于标识希望随`ResourceLoader`引用提供的组件。
```
public interface ResourceLoaderAware {

    void setResourceLoader(ResourceLoader resourceLoader);
}
```
当类实现`ResourceLoaderAware`并部署到应用程序上下文（作为Spring管理的bean）时，它被应用程序上下文识别为`ResourceLoaderAware`。然后，应用程序上下文调用`setResourceLoader(ResourceLoader)`，将其自身作为参数提供（请记住，Spring中的所有应用程序上下文都实现了`ResourceLoader`接口）。

由于`ApplicationContext`是`ResourceLoader`，因此bean还可以实现`ApplicationContextAware`接口并直接使用提供的应用程序上下文来加载资源。但是，通常情况下，如果您需要，最好使用专用的`ResourceLoader`接口。代码只能耦合到资源加载接口（可以认为是实用程序接口），而不是整个Spring ApplicationContext接口。

在应用程序组件中，您还可以依赖`ResourceLoader`的自动装配作为实现`ResourceLoaderAware`接口的替代方法。“传统”构造函数和`byType`自动装配模式（如自动装配协作者中所述）能够分别为构造函数参数或setter方法参数提供`ResourceLoader`。
为了获得更大的灵活性（包括自动装配字段和多参数方法的能力），请考虑使用基于注释的自动装配功能。
在这种情况下，只要有问题的field，构造函数或方法带有`@Autowired`注释，`ResourceLoader`就会自动装入一个字段，构造函数参数或方法参数，这些参数需要`ResourceLoader`类型。

### 2.6 Resources作为依赖
如果bean本身将通过某种动态过程确定并提供资源路径，那么bean使用`ResourceLoader`接口加载资源可能是有意义的。例如，考虑加载某种模板，其中所需的特定资源取决于用户的角色。
如果资源是静态的，那么完全消除`ResourceLoader`接口的使用是有意义的，让bean公开它需要的Resource属性，并期望将它们注入到bean中。

然后注入这些属性变得微不足道的是，所有应用程序上下文都注册并使用特殊的JavaBeans `PropertyEditor`，它可以将String路径转换为`Resource`对象。
因此，如果`myBean`具有`Resource`类型的`template`属性，则可以使用该资源的简单字符串进行配置，如以下示例所示：
```
<bean id="myBean" class="...">
    <property name="template" value="some/resource/path/myTemplate.txt"/>
</bean>
```
请注意，资源路径没有前缀。因此，因为应用程序上下文本身将用作`ResourceLoader`，所以资源本身通过`ClassPathResource`，`FileSystemResource`或`ServletContextResource`加载，具体取决于上下文的确切类型。

如果需要强制使用特定的资源类型，则可以使用前缀。以下两个示例显示如何强制`ClassPathResource`和`UrlResource`（后者用于访问文件系统文件）：
```
<property name="template" value="classpath:some/resource/path/myTemplate.txt">
```
```
<property name="template" value="file:///some/resource/path/myTemplate.txt"/>
```

### 2.7 应用程序上下文和资源路径
本节介绍如何使用资源创建应用程序上下文，包括使用XML的快捷方式，如何使用通配符以及其他详细信息。

#### 2.7.1 构建应用程序上下文
应用程序上下文构造函数（对于特定的应用程序上下文类型）通常将字符串或字符串数​​组作为资源的位置路径，例如构成上下文定义的XML文件。

当这样的位置路径没有前缀时，从该路径构建并用于加载bean定义的特定资源类型取决于并且适合于特定的应用程序上下文。例如，请考虑以下示例，该示例创建`ClassPathXmlApplicationContext`：
```
ApplicationContext ctx = new ClassPathXmlApplicationContext("conf/appContext.xml");
```
bean定义是从类路径加载的，因为使用了`ClassPathResource`。但是，请考虑以下示例，该示例创建`FileSystemXmlApplicationContext`：
```
ApplicationContext ctx =
    new FileSystemXmlApplicationContext("conf/appContext.xml");
```
现在，bean定义是从文件系统位置加载的（在这种情况下，相对于当前工作目录）。请注意，在位置路径上使用特殊类路径前缀或标准URL前缀会覆盖为加载定义而创建的默认资源类型。请考虑以下示例：
```
ApplicationContext ctx =
    new FileSystemXmlApplicationContext("classpath:conf/appContext.xml");
```
使用`FileSystemXmlApplicationContext`从类路径加载bean定义。但是，它仍然是`FileSystemXmlApplicationContext`。如果它随后用作ResourceLoader，则任何未加前缀的路径仍被视为文件系统路径。

##### 构造`ClassPathXmlApplicationContext`实例 - 快捷方式
`ClassPathXmlApplicationContext`公开了许多构造函数，以实现方便的实例化。基本思想是，您只能提供一个字符串数组，该数组只包含XML文件本身的文件名（没有前导路径信息），并且还提供一个Class。
然后，`ClassPathXmlApplicationContext`从提供的类派生路径信息。

请考虑以下目录布局：
```
com/
  foo/
    services.xml
    daos.xml
    MessengerService.class 
```

以下示例显示如何实例化由名为`services.xml`和`daos.xml`（位于类路径中）的文件中定义的bean组成的`ClassPathXmlApplicationContext`实例：
```
ApplicationContext ctx = new ClassPathXmlApplicationContext(
    new String[] {"services.xml", "daos.xml"}, MessengerService.class);
```
有关各种构造函数的详细信息，请参阅[ClassPathXmlApplicationContext](https://docs.spring.io/spring-framework/docs/5.1.6.RELEASE/javadoc-api/org/springframework/jca/context/SpringContextResourceAdapter.html) javadoc。

#### 2.7.2 应用程序上下文构造函数资源路径中的通配符
应用程序上下文构造函数值中的资源路径可能是简单路径（如前所示），每个都与目标资源具有一对一的映射，或者可以包含特殊的"classpath*:"前缀或内部Ant样式的正则表达式（使用Spring的`PathMatcher`实用程序进行匹配）。后者都是有效的通配符。

此机制的一个用途是当您需要进行组件样式的应用程序组装时。所有组件都可以将上下文定义片段“发布”到一个众所周知的位置路径，并且当使用前缀为`classpath*:`的相同路径创建最终应用程序上下文时，将自动拾取所有组件片段。

请注意，此通配符特定于在应用程序上下文构造函数中使用资源路径（或直接使用`PathMatcher`实用程序类层次结构时），并在构造时解析。它与资源类型本身无关。您不能使用`classpath*:`前缀来构造实际的Resource，因为资源一次只指向一个资源。

##### Ant-style Patterns
路径位置可以包含Ant样式模式，如以下示例所示：
```
/WEB-INF/*-context.xml
com/mycompany/**/applicationContext.xml
file:C:/some/path/*-context.xml
classpath:com/mycompany/**/applicationContext.xml
```
当路径位置包含Ant样式模式时，解析程序遵循更复杂的过程来尝试解析通配符。它为直到最后一个非通配符段的路径生成一个Resource，并从中获取一个URL。如果此URL不是jar：URL或特定于容器的变体（例如`zip`：在WebLogic中，在WebSphere中使用`wsjar`，等等），
从中获取`java.io.File`并用于通过遍历文件系统来解析通配符。对于jar URL，解析器要么从中获取`java.net.JarURLConnection`，要么手动解析jar URL，然后遍历jar文件的内容以解析通配符。

##### 对可移植性的影响
如果指定的路径已经是文件URL（隐式，因为基本`ResourceLoader`是文件系统或显式的），则可以保证通配符以完全可移植的方式工作。

如果指定的路径是类路径位置，则解析程序必须通过进行`Classloader.getResource()`调用来获取最后一个非通配符路径段URL。
由于这只是路径的一个节点（不是最后的文件），实际上它是未定义的（在ClassLoader javadoc中），在这种情况下确切地返回了什么类型的URL。
实际上，它总是一个`java.io.File`，表示目录（类路径资源解析为文件系统位置）或某种类型的`jar` URL（类路径资源解析为jar位置）。尽管如此，这项行动仍存在可移植性问题。

...

##### `classpath*:`前缀
`classpath*:` vs `classpath:`

`classpath*:`会整合classpath下所有和指定文件名相同的文件，而`classpath:`只会获取classpath下第一个与指定文件名相同的文件

构建基于XML的应用程序上下文时，位置字符串可以使用特殊的`classpath*:`前缀，如以下示例所示：
```
ApplicationContext ctx =
    new ClassPathXmlApplicationContext("classpath*:conf/appContext.xml");
```
此特殊前缀指定必须获取与给定名称匹配的所有类路径资源(内部，这主要通过调用`ClassLoader.getResources(...)`来实现)然后合并以形成最终的应用程序上下文定义。

> 通配符类路径依赖于底层类加载器的`getResources()`方法。由于现在大多数应用程序服务器都提供了自己的类加载器实现，因此行为可能会有所不同，尤其是在处理jar文件时。
> 检查`classpath*`是否有效的简单测试是使用类加载器从类路径上的jar中加载文件：`getClass().getClassLoader().getResources("<someFileInsideTheJar>")`。
> 尝试使用具有相同名称但放在两个不同位置的文件进行此测试。如果返回了不适当的结果，请检查应用程序服务器文档以获取可能影响类加载器行为的设置。

您还可以将`classpath*:`前缀与`PathMatcher`模式组合使用（例如，`classpath*:META-INF/*-beans.xml`）。在这种情况下，解决策略非常简单:
在最后一个非通配符路径段上使用`ClassLoader.getResources()`调用来获取类加载器层次结构中的所有匹配资源，然后，在每个资源之外，将前面描述的相同`PathMatcher`解析策略用于通配符子路径。

##### 关于通配符的其他说明
请注意，`classpath*:`与Ant样式模式结合使用时，只能在模式启动之前与至少一个根目录可靠地工作，除非实际目标文件驻留在文件系统中。
这意味着`classpath*:*.xml`等模式可能无法从jar文件的根目录中检索文件，而只能从扩展目录的根目录中检索文件。

Spring检索类路径条目的能力来自JDK的`ClassLoader.getResources()`方法，该方法仅返回空字符串的文件系统位置（指示要搜索的潜在根）。
Spring也会评估`URLClassLoader`运行时配置和jar文件中的`java.class.pat`h清单，但这不能保证导致可移植行为。

> 扫描类路径包需要在类路径中存在相应的目录条目。使用Ant构建JAR时，请不要激活JAR任务的仅文件开关。此外，在某些环境中，可能不会基于安全策略公开类路径目录--例如，JDK 1.7.0_45及更高版本上的独立应用程序（需要在清单中设置“Trusted-Library”）。
> 请参阅https://stackoverflow.com/questions/19394570/java-jre-7u45-breaks-classloader-getresources）。
> 
> 在JDK 9的模块路径（Jigsaw）上，Spring的类路径扫描通常按预期工作。此处强烈建议将资源放入专用目录，避免上述搜索jar文件根级别的可移植性问题。

如果要搜索的根包在多个类路径位置中可用，则不保证具有`classpath:`资源的Ant样式模式可以找到匹配的资源。请考虑以下资源位置示例：
```
com/mycompany/package1/service-context.xml
```

现在考虑一个人可能用来尝试查找该文件的Ant风格路径：
```
classpath:com/mycompany/**/service-context.xml
```
这样的资源可能只在一个位置，但是当使用前面例子之类的路径来尝试解析它时，解析器会处理`getResource("com/mycompany");'返回的（第一个）URL。如果此基本包节点存在于多个类加载器位置中，则实际的最终资源可能不存在。
因此，在这种情况下，您应该使用`classpath*:`使用相同的Ant样式模式，该模式搜索包含根包的所有类路径位置。

#### 2.7.3 `FileSystemResource`警告
未附加到`FileSystemApplicationContext`的`FileSystemResource`（即，当`FileSystemApplicationContext`不是实际的`ResourceLoader`时）会按预期处理绝对路径和相对路径。
相对路径相对于当前工作目录，而绝对路径相对于文件系统的根目录。

但是，出于向后兼容性（历史）原因，当`FileSystemApplicationContext`是`ResourceLoader`时，这会发生更改。`FileSystemApplicationContext`强制所有附加的`FileSystemResource`实例将所有位置路径视为相对路径，无论它们是否以前导斜杠开头。
实际上，这意味着以下示例是等效的：
```
ApplicationContext ctx =
    new FileSystemXmlApplicationContext("conf/context.xml");
```
```
ApplicationContext ctx =
    new FileSystemXmlApplicationContext("/conf/context.xml");
```
以下示例也是等效的（即使它们有所不同，因为一个案例是相对的而另一个案例是绝对的）：
```
FileSystemXmlApplicationContext ctx = ...;
ctx.getResource("some/resource/path/myTemplate.txt");
```
```
FileSystemXmlApplicationContext ctx = ...;
ctx.getResource("/some/resource/path/myTemplate.txt");
```
实际上，如果您需要真正的绝对文件系统路径，则应避免对`FileSystemResource`或`FileSystemXmlApplicationContext`使用绝对路径，并使用`file:`URL前缀强制使用`UrlResource`。以下示例显示了如何执行此操作：
```
// actual context type doesn't matter, the Resource will always be UrlResource
ctx.getResource("file:///some/resource/path/myTemplate.txt");
```
```
// force this FileSystemXmlApplicationContext to load its definition via a UrlResource
ApplicationContext ctx =
    new FileSystemXmlApplicationContext("file:///conf/context.xml");
```