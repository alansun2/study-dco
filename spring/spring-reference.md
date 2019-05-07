* [spring参考文档记录](#spring参考文档记录)
  * [Spring框架概述](#spring框架概述)
    * [1.“spring”是什么意思？](#1spring是什么意思？)
    * [2.spring框架的历史](#2spring框架的历史)
    * [3.设计原则](#3设计原则)
    * [4.反馈和贡献](#4反馈和贡献)
    * [5.开始](#5开始)
  * [核心技术](#核心技术)
  * [1. The IoC Container](#1-the-ioc-container)
    * [1.1Spring容器和Beans简介](#11spring容器和beans简介)
    * [1.2 容器概览](#12-容器概览)
        * [1.2.1 配置元数据](#121-配置元数据)
        * [1.2.2 实例化容器](#122-实例化容器)
        * [1.2.3 使用容器](#123-使用容器)
    * [1.3 Bean概览](#13-bean概览)
        * [1.3.1 bean的命名](#131-bean的命名)
        * [1.3.2 实例化bean](#132-实例化bean)
    * [1.4 依赖](#14-依赖)
        * [1.4.1 依赖注入](#141-依赖注入)
            * [1.基于构造器注入（Constructor-based Dependency Injection）](#1基于构造器注入（constructor-based-dependency-injection）)
        * [构造器参数解决方案（Constructor Argument Resolution）](#构造器参数解决方案（constructor-argument-resolution）)
        * [2.基于set的注入（Setter-based Dependency Injection）](#2基于set的注入（setter-based-dependency-injection）)
          * [依赖解决过程](#依赖解决过程)
        * [依赖注入的示例](#依赖注入的示例)
      * [1.4.2 依赖关系和配置的细节](#142-依赖关系和配置的细节)
        * [直值（基元，字符串等）(Straight Values (Primitives, Strings, and so on))](#直值（基元，字符串等）straight-values-primitives-strings-and-so-on)
        * [The idref element](#the-idref-element)
        * [参考其他bean（合作者（被注入的依赖bean））](#参考其他bean（合作者（被注入的依赖bean））)
        * [Inner Beans (内部类)](#inner-beans-内部类)
        * [集合](#集合)
        * [集合合并](#集合合并)
        * [强类型集合（Strongly-typed collection）](#强类型集合（strongly-typed-collection）)
        * [NULL值和空字符串值](#null值和空字符串值)
        * [带有p命名空间的XML快捷方式](#带有p命名空间的xml快捷方式)
        * [带有c命名空间的XML快捷方式 （构造方法）](#带有c命名空间的xml快捷方式-（构造方法）)
        * [复合属性名称 （Compound Property Names）](#复合属性名称-（compound-property-names）)
        * [使用`depends-on`](#使用`depends-on`)
        * [延迟加载](#延迟加载)
      * [1.4.5 自动装配依赖(Autowiring Collaborators)](#145-自动装配依赖autowiring-collaborators)
        * [自动装配的局限和缺点](#自动装配的局限和缺点)
          * [从自动装配中排除Bean](#从自动装配中排除bean)
        * [查找方法注入](#查找方法注入)
        * [任意方法替换](#任意方法替换)
      * [1.5.1 单例](#151-单例)
      * [1.5.2 The Prototype Scope](#152-the-prototype-scope)
        * [Initial Web Configuration](#initial-web-configuration)
        * [Request scope](#request-scope)
        * [Session Scope](#session-scope)
        * [Application Scope](#application-scope)
        * [作为依赖关系的Scoped Bean (Scoped Beans as Dependencies)](#作为依赖关系的scoped-bean-scoped-beans-as-dependencies)
        * [Choosing the Type of Proxy to Create](#choosing-the-type-of-proxy-to-create)
      * [1.5.5 自定义范围](#155-自定义范围)
        * [创建自定义范围](#创建自定义范围)
        * [使用自定义范围](#使用自定义范围)
    * [1.6 定制Bean的本质](#16-定制bean的本质)

# spring参考文档记录

## Spring框架概述
spring是一个轻量的java企业级应用开发框架，它提供了开发Java企业级应用的一切，同时支持Groovy和Kotlin，可根据应用程序的需要灵活地创建多种体系结构。spring5.1后最低支持到jdk8而且为jdk11提供了开箱即用。

### 1.“spring”是什么意思
"spring"在不同的情况下表达不同的意思。它可以用来引用Spring Framework框架本身，它就是一切开始的地方。随着时间的推移，其他Spring项目已经构建在Spring Framework之上（比如springboot，spring-cloud）。大多数情况下，我们说“spring”
它是指整个整个spring家族。**此参考文档是基于该基础：Spring Framework本身（不包括如spring-boot等）**。

Spring Framework被拆成了多个模块。应用可以选择他们需要的模块。核心容器模块包括**配置模型（configuration model）**和**依赖注入机制（dependency injection mechanism）**。除此之外，Spring Framework也为不同的应用提供了基础的
支持，包括消息，事务，持久化，和web开发。它还包括了基于Servlet的`Spring MVC`web框架，并行，`Spring WebFlux`响应式web框架。

*关于模块的说明*：Spring的框架jar允许部署到JDK 9的模块路径（“Jigsaw”）。
```
A note about modules: Spring’s framework jars allow for deployment to JDK 9’s module path ("Jigsaw"). 
For use in Jigsaw-enabled applications, the Spring Framework 5 jars come with "Automatic-Module-Name"
 manifest entries which define stable language-level module names ("spring.core", "spring.context" etc) 
 independent from jar artifact names (the jars follow the same naming pattern with "-" instead of ".", 
 e.g. "spring-core" and "spring-context"). Of course, Spring’s framework jars keep working fine on the 
 classpath on both JDK 8 and 9+.
```

### 2.spring框架的历史
### 3.设计原则
### 4.反馈和贡献
### 5.开始

## 核心技术
这部分参考文档涵盖了Spring Framework绝对不可或缺的所有技术。

其中最重要的是Spring Framework的控制反转（IoC）容器。Spring框架的IoC容器的全面处理紧随其后，全面覆盖了Spring的面向切面编程（AOP）技术。Spring有自己的AOP框架，这在概念上很容易理解，它成功地解决了Java企业编程中AOP要求的80％
最佳点。

还提供了Spring与AspectJ（目前最丰富的 - 在功能方面 - 当然也是Java企业领域中最成熟的AOP实现）集成的覆盖范围。

## 1. The IoC Container
This chapter covers Spring’s Inversion of Control (IoC) container.

### 1.1 Spring容器和Beans简介
本章介绍了控制反转（IoC）原理的Spring Framework实现。总所周知，ioc就是依赖注入。这是一个过程，通过这个过程，对象只能通过构造函数参数，工厂方法的参数或在构造或从工厂方法返回后在对象实例上设置的属性来定义它们的依赖关系（即，它
们使用的其他对象）。然后容器在创建bean时注入这些依赖项。此过程基本上是bean本身的逆（因此名称，控制反转），通过使用类的直接构造或诸如服务定位器模式的机制来控制其依赖关系的实例化或位置。（This process is fundamentally the
 inverse (hence the name, Inversion of Control) of the bean itself controlling the instantiation or location of its dependencies by using direct construction of classes or a mechanism such as the Service 
 Locator pattern.）

`org.springframework.beans`和`org.springframework.context`是spring ioc容器的基础。`BeanFactory`接口提供了一种能够管理任何类型对象的高级配置机制。`ApplicationContext`是`BeanFactory`的子接口。它（`ApplicationContext`）
增加了:

* 更容易与Spring的AOP功能集成
* 消息资源处理（用于国际化）
* 时间发布
* 特定于应用程序层的上下文，例如WebApplicationContext，用于Web应用程序。

简而言之，BeanFactory提供了配置框架和基本功能，ApplicationContext添加了更多特定于企业的功能。`ApplicationContext`是`BeanFactory`的完整超集，在本章中仅用于Spring的IoC容器的描述。有关使用`BeanFactory`而不是
`ApplicationContext`的更多信息，请参阅[`The BeanFactory`](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-beanfactory)。

**在Spring中，构成应用程序主干并由Spring IoC容器管理的对象称为bean。bean是一个由Spring IoC容器实例化，组装和管理的对象。另外，bean只是应用程序中许多对象之一。 Bean及其之间的依赖关系反映在容器使用的配置元数据中。**

### 1.2 容器概览
`org.springframework.context.ApplicationContext`接口表示Spring IoC容器，负责实例化，配置和组装bean。容器通过读取配置元数据获取有关要实例化，配置和组装的对象的信息。**配置元数据以XML，Java注解(@Service等)或Java代码表示（@Bean）。**
它允许您表达组成应用程序的对象以及这些对象之间丰富的相互依赖性。

Spring提供了`ApplicationContext`接口的几个实现。在独立应用程序中，通常会创建`ClassPathXmlApplicationContext`或`FileSystemXmlApplicationContext的实例。虽然XML是定义配置元数据的传统格式，但您可以通过提供少量XML配置来声明容器使用Java注释或代码作为元数据格式，以声明方式启用对这些其他元数据格式的支持。

在大多数应用场景中，不需要显式用户代码来实例化Spring IoC容器的一个或多个实例。例如，在Web应用程序场景中，应用程序的web.xml文件中的简单八行（左右）样板Web描述符XML通常就足够了。If you use the Spring Tool Suite 
(an Eclipse-powered development environment), you can easily create this boilerplate configuration with a few mouse clicks or keystrokes.

下图显示了Spring如何工作的高级视图。您的应用程序类与配置元数据相结合，以便在创建和初始化ApplicationContext之后，您拥有一个完全配置且可执行的系统或应用程序。

![Figure 1. The Spring IoC container](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/images/container-magic.png "Figure 1. The Spring IoC container")

#### 1.2.1 配置元数据
如上图所示，Spring IoC容器使用一种配置元数据。此配置元数据表示您作为应用程序开发人员如何告诉Spring容器在应用程序中实例化，配置和组装对象。

传统上，配置元数据以简单直观的XML格式提供，本章大部分内容都是用xml的格式传达Spring IoC容器的关键概念和功能。

>基于XML的元数据不是唯一允许的配置元数据形式。Spring IoC容器本身完全与实际编写此配置元数据的格式分离。目前，许多开发人员为其Spring应用程序选择[基于Java](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-java)的配置。

有关在Spring容器中使用其他形式的元数据的信息，请参阅：

* [基于注解的配置](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-annotation-config)： Spring 2.5引入了对基于注释的配置元数据的支持。
* [基于Java代码的配置](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-java)：从Spring 3.0开始，Spring JavaConfig项目提供的许多功能都成为核心Spring Framework的一部分。
因此，您可以使用Java而不是XML文件在应用程序类外部定义bean。To use these new features, see the @Configuration, @Bean, @Import, and @DependsOn annotations.

Spring配置包含容器必须管理的至少一个且通常不止一个bean定义。基于xml的元数据配置，通过将`<bean/>`定义在`<beans/>`的顶级的方法配置。Java配置通常在`@Configuration`类中使用`@Bean`注解的方法。

这些bean定义对应于构成应用程序的实际对象。通常，您定义服务层对象，数据访问对象（DAO），表示对象（如Struts Action实例），基础结构对象（如Hibernate `SessionFactories`，JMS `Queues`等）。通常，不会在容器中配置细粒度域对象，
因为DAO和业务逻辑通常负责创建和加载域对象。但是，您可以使用Spring与AspectJ的集成来配置在IoC容器控制之外创建的对象。see [Using AspectJ to dependency-inject domain objects with Spring](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#aop-atconfigurable)。

以下示例显示了基于XML的配置元数据的基本结构：
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="..." class="..."> 1,2
        <!-- collaborators and configuration for this bean go here -->
    </bean>

    <bean id="..." class="...">
        <!-- collaborators and configuration for this bean go here -->
    </bean>

    <!-- more bean definitions go here -->

</beans>
```
* id属性是一个标识单个bean定义的字符串。
* class属性定义bean的类型并使用完全限定的classname。

The value of the id attribute refers to collaborating objects. The XML for referring to collaborating objects is not shown in this example. See Dependencies for more information.

#### 1.2.2 实例化容器
提供给ApplicationContext构造函数的位置路径是资源字符串，它允许容器从各种外部资源（如本地文件系统，Java CLASSPATH等）加载配置元数据。
```
ApplicationContext context = new ClassPathXmlApplicationContext("services.xml", "daos.xml");
```

> 在了解了Spring的IoC容器之后，您可能想要了解有关Spring的[Resource](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#resources)抽象的更多信息（如参考资料中所述）,它提供了一种方便的机制，用于从URI语法中定义的位置读取InputStream。特别是，资源路径用于构建应用程序上下文，如[应用程序上下文和资源路径](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#resources-app-ctx)中所述。

以下示例显示了服务层对象（services.xml）配置文件：

```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd">

    <!-- services -->

    <bean id="petStore" class="org.springframework.samples.jpetstore.services.PetStoreServiceImpl">
        <property name="accountDao" ref="accountDao"/>
        <property name="itemDao" ref="itemDao"/>
        <!-- additional collaborators and configuration for this bean go here -->
    </bean>

    <!-- more bean definitions for services go here -->

</beans>
```

以下示例显示了数据访问对象daos.xml文件：
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="accountDao"
        class="org.springframework.samples.jpetstore.dao.jpa.JpaAccountDao">
        <!-- additional collaborators and configuration for this bean go here -->
    </bean>

    <bean id="itemDao" class="org.springframework.samples.jpetstore.dao.jpa.JpaItemDao">
        <!-- additional collaborators and configuration for this bean go here -->
    </bean>

    <!-- more bean definitions for data access objects go here -->

</beans>
```

在前面的示例中，服务层由`PetStoreServiceImpl`类和`JpaAccountDao`和`JpaItemDao`类型的两个数据访问对象组成（基于JPA对象关系映射标准）。属性`name`元素引用JavaBean属性的名称，`ref`元素引用另一个bean定义的名称。 
`id`和`ref`元素之间的这种联系表达了协作对象（各个由spring容器创建的对象）之间的依赖关系。有关配置对象的依赖关系的详细信息，请参[Dependencies](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-dependencies)

<font size="5">编写基于XML的配置元数据</font>

让bean定义跨越多个XML文件会很有用。通常，每个单独的XML配置文件都代表架构中的逻辑层或模块。

您可以使用应用程序上下文构造函数从所有这些XML片段加载bean定义。您可以使用应用程序上下文构造函数从所有这些XML片段加载bean定义。此构造函数采用多个Resource位置，如上一节中所示。或者，使用一个或多个`<import/>`元素来
从另一个或多个文件加载bean定义。如：
```
<beans>
    <import resource="services.xml"/>
    <import resource="resources/messageSource.xml"/>
    <import resource="/resources/themeSource.xml"/>

    <bean id="bean1" class="..."/>
    <bean id="bean2" class="..."/>
</beans>
```
在前面的示例中，外部bean定义从三个文件加载：`services.xml`，`messageSource.xml`和`themeSource.xml`。所有位置路径都相对于执行导入的定义文件，所以`services.xml`必须与执行导入的文件位于同一目录或类路径位置，
而messageSource.xml和themeSource.xml必须位于导入文件位置下方的`resources`中。**如您所见，忽略前导斜杠。但是，鉴于这些路径是相对的，最好不要使用斜杠。**
根据Spring Schema，正在导入的文件的内容（包括顶级`<beans />`元素）必须是有效的XML bean定义。

> 可以（但不建议）使用相对“../”路径引用父目录中的文件。这样做会对当前应用程序之外的文件创建依赖关系。特别是，不建议对classpath使用此引用：URL（例如，classpath：../ services.xml），其中运行时解析过程选择“最近的”类路径根，然后查看其父目录。类路径配置更改可能导致选择不同的，不正确的目录。
> 您始终可以使用完全限定的资源位置而不是相对路径：例如，file：C：/config/services.xml或classpath：/config/services.xml。但是，请注意您将应用程序的配置与特定的绝对位置耦合。通常最好为这些绝对位置保持间接 - 例如，通过在运行时针对JVM系统属性解析的“$ {...}”占位符。

命名空间本身提供了import指令功能。除了普通bean定义之外的其他配置功能在Spring提供的一系列XML命名空间中可用 - 例如，`context`和`util`命名空间。

<font size="5">The Groovy Bean Definition DSL</font>
```
beans {
    dataSource(BasicDataSource) {
        driverClassName = "org.hsqldb.jdbcDriver"
        url = "jdbc:hsqldb:mem:grailsDB"
        username = "sa"
        password = ""
        settings = [mynew:"setting"]
    }
    sessionFactory(SessionFactory) {
        dataSource = dataSource
    }
    myService(MyService) {
        nestedBean = { AnotherBean bean ->
            dataSource = dataSource
        }
    }
}
```

此配置样式在很大程度上等同于XML bean定义，甚至支持Spring的XML配置命名空间。它还允许通过importBeans指令导入XML bean定义文件。

#### 1.2.3 使用容器
`ApplicationContext`是高级工厂的接口，能够维护不同bean及其依赖项的注册表。通过使用方法`T getBean（String name，Class <T> requiredType）`，您可以获取到bean的实例。

`ApplicationContext`允许您读取bean定义并访问它们，如以下示例所示：
```
// create and configure beans
ApplicationContext context = new ClassPathXmlApplicationContext("services.xml", "daos.xml");

// retrieve configured instance
PetStoreService service = context.getBean("petStore", PetStoreService.class);

// use configured instance
List<String> userList = service.getUsernameList();
```
使用Groovy配置，bootstrapping看起来非常相似。它有一个不同的上下文实现类，它是Groovy-aware（但也理解XML bean定义）。以下示例显示了Groovy配置：
```
ApplicationContext context = new GenericGroovyApplicationContext("services.groovy", "daos.groovy");
```

最灵活的变体是GenericApplicationContext与读者代表的组合--例如，使用XML文件的XmlBeanDefinitionReader，如以下示例所示：
```
GenericApplicationContext context = new GenericApplicationContext();
new XmlBeanDefinitionReader(context).loadBeanDefinitions("services.xml", "daos.xml");
context.refresh();
```
您还可以将GroovyBeanDefinitionReader用于Groovy文件，如以下示例所示：
```
GenericApplicationContext context = new GenericApplicationContext();
new GroovyBeanDefinitionReader(context).loadBeanDefinitions("services.groovy", "daos.groovy");
context.refresh();
```
你可以把不同reader委托给同一个`ApplicationContext`,从不同的配置源中读取bean定义

然后，您可以使用getBean来检索Bean的实例。 ApplicationContext接口有一些其他方法可以检索bean，但理想情况下，应用程序代码永远不应该使用它们。实际上，您的应用程序代码根本不应该调用getBean（）方法，因此根本不依赖于Spring API。
例如，Spring与Web框架的集成为各种Web框架组件（如控制器和JSF托管bean）提供依赖注入，允许您通过元数据（例如自动装配注释）声明对特定bean的依赖性。

### 1.3 Bean概览
一个Spring IoC容器管理一个或多个bean。这些bean是使用您提供给容器的配置元数据创建的（例如，以XML `<bean />`定义的形式）。

在容器内部，这些bean定义表示为`BeanDefinition`对象，其中包含（以及其他信息）以下元数据：

* 包限定的类名：通常，定义的bean的实际实现类。
* bean的行为，bean在容器中的行为方式（scope, lifecycle callbacks等等）
* 引用bean执行其工作所需的其他bean。这些引用也称为协作者或依赖项。（依赖信息）
* 要在新创建的对象中设置的其他配置设置--例如，池的大小限制或在管理连接池的Bean中使用的连接数。

此元数据转换为构成每个bean定义的一组属性。下表描述了这些属性：

Property|Explained in…​
--|:--
Class | [Instantiating Beans](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-class)
Name | [Naming Beans](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-beanname)
Scope | [Bean Scopes](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-scopes)
Constructor arguments | [Dependency Injection](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-collaborators)
Properties | [Dependency Injection](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-collaborators)
Autowiring mode | [Autowiring Collaborators](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-autowire)
Lazy initialization mode | [Lazy-initialized Beans](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-lazy-init)
Initialization method | [Initialization Callbacks](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-lifecycle-initializingbean)
Destruction method | [Destruction Callbacks](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-lifecycle-disposablebean)

除了包含有关如何创建特定bean的信息的bean定义之外，`ApplicationContext`实现还允许容器外部（由用户）创建的现有对象的注册。这是通过`getBeanFactory（）`方法访问`ApplicationContext`的BeanFactory来完成的，此方法会返回一个BeanFactory 
`DefaultListableBeanFactory`实现类。`DefaultListableBeanFactory`通过`registerSingleton（..）`和`registerBeanDefinition（..`）方法注册用户自己的类。但是，一般的应用程序仅使用通过常规bean定义元数据定义的bean。

> 需要尽早注册Bean元数据和手动提供的单例实例，以便容器在自动装配和其他内省步骤期间正确推理它们。虽然在某种程度上支持覆盖现有元数据和现有单例实例，
> 但是在运行时注册新bean（与对工厂的实时访问同时）并未得到官方支持，并且可能导致并发访问异常，bean容器中的状态不一致，或者都。

#### 1.3.1 bean的命名
每个bean都有一个或多个标识符。这些标识符在托管bean的容器中必须是唯一的。bean通常只有一个标识符。但是，如果它需要多个，则额的外标识符可以被视为别名。

在基于XML的配置元数据中，使用`id`属性，`name`属性或两者来指定bean标识符。`id`属性允许您精确的指定一个标识符。通常，这些名称是字母数字（'myBean'，'someService'等），但它们也可以包含特殊字符。如果要为bean引入别名，
还可以在`name`属性中指定它们，用逗号（`,`），分号（`;`）或空格分隔。在Spring 3.1之前的版本中，id属性被定义为`xsd:ID`类型，它约束了可能的字符。从3.1开始，它被定义为`xsd:string`类型。

为bean提供`name`或`id`不是必须的。如果未明确提供`name`或`id`，则容器会为该Bean生成唯一的名称。但是，如果要通过名称引用该bean，通过使用ref元素或Service Locator样式查找，则必须提供名称。不提供名称的原因与使用内
部bean和自动装配协作者有关。

<div style="background-color: #f7f7f8">
    <h3 style="text-align: center;">bean命名约定</h3>
    <p>
        约定就是在命名bean时使用标准Java约定作为实例字段名称。也就是说，bean名称以小写字母开头，并从那里开始驼峰。比如accountManager，accountService，userDao，loginController等。
        统一bean命名规则使您的配置更易于阅读和理解。此外，如果您使用Spring AOP，那么在将建议应用于与名称相关的一组bean时，它会有很大帮助。
    </p>
</div>

> 通过类路径中的组件扫描(component scanning)，Spring按照前面描述的规则为未命名的组件生成bean名称。本质上，采用简单的类名并将其初始字符转换为小写。但是，在特殊情况下，当有多个字符且第一个和第二个字符都是大写字母时
> ，将使用原始的类名。这些规则与java.beans.Introspector.decapitalize（Spring在此处使用）中定义的规则相同。

<font size="5">在Bean Definition之外为bean设置别名</font>

在bean定义本身中，您可以为bean提供多个名称，方法是使用id属性指定的最多一个`id`和`name`属性中的任意数量的其他名称。这些名称可以是同一个bean的等效别名，对某些情况很有用，例如让应用程序中的每个组件通过使用特定于该组件本身的
bean名称来引用公共依赖项。

在bean定义中指定所有别名有时候无法满足需要，有时需要为其他地方定义的bean引入别名。在大型系统中通常就是这种情况，其中配置在每个子系统之间分配，每个子系统具有其自己的一组对象定义。在基于XML的配置元数据中，您可以使用
`<alias />`元素来完成此任务。以下示例显示了如何执行此操作：
```
<alias name="fromName" alias="toName"/>
```
fromName为原来bean的名字，toName为新的别名

例如，子系统A的配置元数据可以通过`subsystemA-dataSourc`e的名称来引用DataSource。子系统B的配置元数据可以通过`subsystemB-dataSource`的名称引用DataSource。在编写使用这两个子系统的主应用程序时，主应用程序通过
`myApp-dataSource`的名称引用DataSource。要使所有三个名称引用同一对象，可以将以下别名定义添加到配置元数据中:
```
<alias name="myApp-dataSource" alias="subsystemA-dataSource"/>
<alias name="myApp-dataSource" alias="subsystemB-dataSource"/>
```
现在，每个组件和主应用程序都可以通过一个唯一的名称引用dataSource，并保证不与任何其他定义冲突（有效地创建命名空间），但它们引用相同的bean。

<div style="background-color: #f7f7f8">
    <h3 style="text-align: center;">Java-configuration</h3>
    <p>
        如果使用Javaconfiguration，则@Bean注释可用于提供别名。有关详细信息，请参阅使用@Bean批注。
    </p>
</div>

#### 1.3.2 实例化bean
bean definition本质上是用于创建一个或多个对象的配方。当需要bean definition创建实例时，容器会去会去查看这个bean的配方（也就是bean信息）。

如果使用基于XML的配置元数据，则指定要在`<bean />`元素的`class`属性中实例化的对象的类型（或类）。`class`属性（在内部，是`BeanDefinition`实例上的Class属性）通常是必需的。
（有关例外，请参阅使用[Instantiation by Using an Instance Factory Method](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-class-instance-factory-method)和[Bean Definition Inheritance](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-child-bean-definitions)。）您可以通过以下两种方式之一使用`Class`属性:

* 通常，在容器本身通过反射调用其构造函数直接创建bean的情况下指定要构造的bean类，稍微等同于使用new运算符的Java代码。
* 通过静态工厂方法实例化bean。在不太常见的情况下，容器在类上调用静态工厂方法来创建bean。从静态工厂方法的调用返回的对象类型可以完全是同一个类或另一个类。

<div style="background-color: #f7f7f8">
    <h6>Inner class names</h6>
    <p>
        如果要为静态内部类配置bean定义，则必须使用内部类的二进制名称。
        <p></p>
        例如，如果在com.example包中有一个名为SomeThing的类，并且此SomeThing类具有一个名为OtherThing的静态内部类，则bean定义上的class属性值将为com.example.SomeThing$OtherThing。
        <p></p>
        <strong>请注意，在名称中使用$字符可以将内部类名与外部类名分开。</strong>
    </p>
</div>

<font size="4">使用构造函数实例化</font>

当您通过构造方法创建bean时，所有普通类都可以使用并与Spring兼容。也就是说，正在开发的类不需要实现任何特定接口或以特定方式编码。简单地指定bean类就足够了。但是，根据您为该特定bean使用的IoC类型，您可能需要一个默认（空）构造函数。

Spring IoC容器几乎可以管理您希望它管理的任何类。它不仅限于管理真正的JavaBeans。大多数Spring用户更喜欢实际的JavaBeans，只有一个默认（无参数）构造函数，并且在容器中的属性之后建模了适当的setter和getter。您还可以在容器中拥有
更多外来的非bean样式类。例如，如果您需要使用绝对不符合JavaBean规范的旧连接池，那么Spring也可以对其进行管理。

使用基于XML的配置元数据，您可以按如下方式指定bean类：

```
<bean id="exampleBean" class="examples.ExampleBean"/>

<bean name="anotherExample" class="examples.ExampleBeanTwo"/>
```

有关为构造函数提供参数的机制（如果需要）以及在构造对象后设置对象实例属性的详细信息，请参阅 [Injecting Dependencies](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-collaborators)。


<font size="4">使用静态工厂实例化</font>

定义使用静态工厂方法创建的bean时，请使用`class`属性指定包含静态工厂方法的类和名为`factory-method`的属性，以指定工厂方法本身的名称。您应该能够调用此方法（使用可选参数，如稍后所述）并返回一个活动对象，随后将其视为通过构造函数
创建的对象。这种bean定义的一个用途是在遗留代码中调用静态工厂。

以下bean定义指定通过调用工厂方法来创建bean。该定义未指定返回对象的类型（类），仅指定包含工厂方法的类。在此示例中，createInstance（）方法必须是静态方法。以下示例显示如何指定工厂方法：
```
<bean id="clientService"
    class="examples.ClientService"
    factory-method="createInstance"/>
```
ClientService是一个静态工厂类，可以实例化类。

以下示例显示了一个可以使用前面的bean定义的类：
```
public class ClientService {
    private static ClientService clientService = new ClientService();
    private ClientService() {}

    public static ClientService createInstance() {
        return clientService;
    }
}
```

有关在从工厂返回对象后为工厂方法提供（可选）参数和设置对象实例属性的机制的详细信息，请参阅[Dependencies and Configuration in Detail](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-properties-detailed)。

<font size="4">使用实例工厂方法实例化</font>

与通过静态工厂方法实例化类似，使用实例工厂方法进行实例化会从容器调用现有bean的非静态方法来创建新bean。要使用此机制，请将`class`属性保留为空，并在`factory-bean`属性中指定当前（或父或祖先）容器中bean的名称，该容器包含要调用以创建
对象的实例方法。使用`factory-method`属性设置工厂方法本身的名称。以下示例显示如何配置此类bean：
```
<!-- the factory bean, which contains a method called createInstance() -->
<bean id="serviceLocator" class="examples.DefaultServiceLocator">
    <!-- inject any dependencies required by this locator bean -->
</bean>

<!-- the bean to be created via the factory bean -->
<bean id="clientService"
    factory-bean="serviceLocator"
    factory-method="createClientServiceInstance"/>
```

以下示例显示了相应的Java类：
```
public class DefaultServiceLocator {

    private static ClientService clientService = new ClientServiceImpl();

    public ClientService createClientServiceInstance() {
        return clientService;
    }
}
```

一个工厂类也可以包含多个工厂方法，如以下示例所示：
```
<bean id="serviceLocator" class="examples.DefaultServiceLocator">
    <!-- inject any dependencies required by this locator bean -->
</bean>

<bean id="clientService"
    factory-bean="serviceLocator"
    factory-method="createClientServiceInstance"/>

<bean id="accountService"
    factory-bean="serviceLocator"
    factory-method="createAccountServiceInstance"/>
```
以下示例显示了相应的Java类：
```
public class DefaultServiceLocator {

    private static ClientService clientService = new ClientServiceImpl();

    private static AccountService accountService = new AccountServiceImpl();

    public ClientService createClientServiceInstance() {
        return clientService;
    }

    public AccountService createAccountServiceInstance() {
        return accountService;
    }
}
```

这种方法表明工厂bean本身可以通过依赖注入（DI）进行管理和配置。请参阅[Dependencies and Configuration in Detail](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-properties-detailed)。

> **在Spring文档中，“factory bean”是指在Spring容器中配置并通过实例或静态工厂方法创建对象的bean。相比之下，FactoryBean（注意大小写）是指特定于Spring的FactoryBean,它是spring中的一个普通bean。**

### 1.4 依赖
典型的企业应用程序不包含单个对象（或Spring用法中的bean）。即使是最简单的应用程序也有一些对象可以协同工作，以呈现最终用户所看到的连贯应用程序。下一节将介绍如何定义多个独立的bean定义，以及对象协作实现目标的完全实现的应用程序。

#### 1.4.1 依赖注入
依赖注入（DI）是一个过程，通过这个过程，对象只能通过构造函数参数，工厂方法的参数或在构造方法或从工厂方法返回的对象实例上设置的属性来定义它们的依赖关系（即，它们使用的其他对象）。然后容器在创建bean时注入这些依赖项。
这个过程基本上是bean本身的反向（因此名称，控制反转），它通过使用类的直接构造或服务定位器模式来控制其依赖项的实例化或位置。

使用DI原则的代码更清晰，当对象提供其依赖项时，解耦更有效。该对象不查找其依赖项，也不知道依赖项的位置或类。因此，您的类变得更容易测试，特别是当依赖关系在接口或抽象基类上时，这允许在单元测试中使用存根或模拟实现。

DI存在两个主要变体：基于构造函数的依赖注入（Constructor-based dependency injection）和基于Setter的依赖注入（Setter-based dependency injection）。

##### 1.基于构造器注入（Constructor-based Dependency Injection）
基于构造函数的DI由容器调用具有多个参数的构造函数来完成，每个参数表示一个依赖项。调用具有特定参数的静态工厂方法来构造bean几乎是等效的，本讨论同样处理构造函数和静态工厂方法的参数。
以下示例显示了一个只能通过构造函数注入进行依赖注入的类：

```
public class SimpleMovieLister {

    // the SimpleMovieLister has a dependency on a MovieFinder
    private MovieFinder movieFinder;

    // a constructor so that the Spring container can inject a MovieFinder
    public SimpleMovieLister(MovieFinder movieFinder) {
        this.movieFinder = movieFinder;
    }

    // business logic that actually uses the injected MovieFinder is omitted...
}
```

请注意，这个类没有什么特别之处。它是一个POJO，它不依赖于容器特定的接口，基类或注释。

##### 构造器参数解决方案（Constructor Argument Resolution）
通过使用参数的类型进行构造函数参数解析匹配。通过使用参数的类型进行构造函数参数解析匹配。如果bean定义的构造函数参数中不存在潜在的歧义，那么在bean定义中定义构造函数参数的顺序是在实例化bean时将这些参数提供给适当的构造函数的顺序。
考虑以下类：
```
package x.y;

public class ThingOne {

    public ThingOne(ThingTwo thingTwo, ThingThree thingThree) {
        // ...
    }
}
```
假设ThingTwo和ThingThree类与继承无关，则不存在潜在的歧义。因此，以下配置工作正常，您无需在`<constructor-arg />`元素中显式指定构造函数参数索引或类型。
```
<beans>
    <bean id="beanOne" class="x.y.ThingOne">
        <constructor-arg ref="beanTwo"/>
        <constructor-arg ref="beanThree"/>
    </bean>

    <bean id="beanTwo" class="x.y.ThingTwo"/>

    <bean id="beanThree" class="x.y.ThingThree"/>
</beans>
```
*构造器参数类型匹配（Constructor argument type matching）*

在前面的场景中，如果使用type属性显式指定构造函数参数的类型，则容器可以使用与简单类型匹配的类型。如下例所示：
```
<bean id="exampleBean" class="examples.ExampleBean">
    <constructor-arg type="int" value="7500000"/>
    <constructor-arg type="java.lang.String" value="42"/>
</bean>
```

*构造器参数下标（Constructor argument index）*

您可以使用index属性显式指定构造函数参数的索引，如以下示例所示：
```
<bean id="exampleBean" class="examples.ExampleBean">
    <constructor-arg index="0" value="7500000"/>
    <constructor-arg index="1" value="42"/>
</bean>
```
除了解决多个简单值的歧义之外，指定索引还可以解决构造函数具有相同类型的两个参数的歧义。

> 下标从0开始

*构造器参数名称（Constructor argument name）*

您还可以使用构造函数参数名称进行值消歧，如以下示例所示：
```
<bean id="exampleBean" class="examples.ExampleBean">
    <constructor-arg name="years" value="7500000"/>
    <constructor-arg name="ultimateAnswer" value="42"/>
</bean>
```

请记住，为了使这项工作开箱即用，必须在启用调试标志的情况下编译代码，以便Spring可以从构造函数中查找参数名称。如果您不能或不想使用debug标志编译代码，则可以使用@ConstructorProperties JDK批注显式命名构造函数参数。

##### 2.基于set的注入（Setter-based Dependency Injection）
基于setter的DI是在调用无参数构造函数或无参数静态工厂方法来实例化bean之后，通过容器调用bean上的setter方法来完成的。

以下示例显示了一个只能通过使用纯setter注入进行依赖注入的类。这个类是传统的Java。它是一个POJO，它不依赖于容器特定的接口，基类或注释。

```
public class SimpleMovieLister {

    // the SimpleMovieLister has a dependency on the MovieFinder
    private MovieFinder movieFinder;

    // a setter method so that the Spring container can inject a MovieFinder
    public void setMovieFinder(MovieFinder movieFinder) {
        this.movieFinder = movieFinder;
    }

    // business logic that actually uses the injected MovieFinder is omitted...
}
```

`ApplicationContext`支持它管理的bean的基于构造函数和基于setter的DI。它还支持在通过构造函数方法注入了一些依赖项之后，然后再setter的DI。您可以以BeanDefinition的形式配置依赖项，您可以将它与PropertyEditor实例结合使用，
将属性从一种格式转换为另一种格式。但是，大多数Spring用户不直接使用这些类（即以编程方式），而是使用XML bean定义，带注释的组件（即使用@ Component，@ Controller等注释的类）或者@Bean方法。基于Java的@Configuration类。
然后，这些源在内部转换为BeanDefinition的实例，并用于加载整个Spring IoC容器实例。

<div style="background-color: #f7f7f8">
    <h3 style="text-align: center;">Constructor-based or setter-based DI?</h3>
    <p>
        由于您可以混合基于构造函数和基于setter的DI，因此将构造函数用于强制依赖项，setter方法或配置方法用于可选依赖项的是一个很好的经验法则。请注意，在setter方法上使用@Required注释可用于使属性成为必需的依赖项;
        但是，最好使用编程验证参数的构造函数注入。
        <p></p>
        Spring团队通常提倡构造函数注入，因为它允许您将应用程序组件实现为不可变对象，并确保所需的依赖项不为null。此外，构造函数注入的组件始终以完全初始化的状态返回到客户端（调用）代码。
        作为旁注，大量的构造函数参数是一个bad code smell，暗示该类可能有太多的责任，应该重构以更好地解决关注点的正确分离。
        <p></p>
        Setter注入应主要仅用于可在类中指定合理默认值的可选依赖项。否则，必须在代码使用依赖项的任何位置执行非空检查。setter注入的一个好处是setter方法使该类的对象可以在以后重新配置或重新注入。
        因此，通过JMX MBean进行管理是二次注入的一个引人注目的用例。
        <p></p>
        使用对特定类最有意义的DI样式。有时，在处理您没有源的第三方类时会用到它。例如，如果第三方类没有公开任何setter方法，那么构造函数注入可能是唯一可用的DI形式。
    </p>
</div>

###### 依赖解决过程
容器执行bean依赖性解析，如下所示：

* `ApplicationContext`是使用描述所有bean的配置元数据创建和初始化的。配置元数据可以由XML，Java代码或注释指定。
* 对于每个bean，它的依赖关系以属性，构造函数参数或static-factory方法的参数的形式表示（如果使用它而不是普通的构造函数）。实际创建bean时，会将这些依赖项提供给bean。
* 每个属性或构造函数参数都是要设置的值的实际定义，或者是对容器中另一个bean的引用。
* 作为值的每个属性或构造函数参数都从其指定的格式转换为该属性或构造函数参数的实际类型。默认情况下，Spring可以将以字符串格式提供的值转换为所有内置类型，例如int，long，String，boolean等。

Spring容器在创建容器时验证每个bean的配置。但是，在实际创建bean之前，不会设置bean属性本身。创建容器时会创建单例作用域并设置为预实例化（默认值）的Bean。Scope在Bean scope中定义。否则，仅在请求时才创建bean。
创建bean可能会潜在的导致创建bean的图形，因为bean的依赖关系及依赖的依赖关系（依此类推）被创建和分配。请注意，这些依赖项之间的不匹配可能会延迟 - 也就是说，首次创建受影响的bean时。

```
The Spring container validates the configuration of each bean as the container is created. However, the bean properties themselves are not set until the bean is actually created. 
Beans that are singleton-scoped and set to be pre-instantiated (the default) are created when the container is created. Scopes are defined in Bean Scopes. Otherwise, the bean is
 created only when it is requested. Creation of a bean potentially causes a graph of beans to be created, as the bean’s dependencies and its dependencies' dependencies (and so on)
  are created and assigned. Note that resolution mismatches among those dependencies may show up late — that is, on first creation of the affected bean.
```

<div style="background-color: #f7f7f8">
    <h3 style="text-align: center;">循环依赖（Circular dependencies）</h3>
    <p>
        如果您主要使用构造函数注入，则可以创建无法解析的循环依赖关系。
        <p></p>
        例如：类A通过构造函数注入需要类B的实例，而类B通过构造函数注入需要类A的实例。如果为A类和B类配置bean相互注入，则Spring IoC容器会在运行时检测此循环引用，并抛出BeanCurrentlyInCreationException。
        <p></p>
        一种可能的解决方案是编辑由setter而不是构造函数配置的某些类的源代码。或者，避免构造函数注入并仅使用setter注入。换句话说，尽管不推荐使用，但您可以使用setter注入配置循环依赖项。
        <p></p>
        与典型情况（没有循环依赖）不同，bean A和bean B之间的循环依赖强制其中一个bean在完全初始化之前被注入另一个bean（一个经典的鸡与鸡蛋场景）。比如A被强制注入到B，但是A在B之后完全实例化。
    </p>
</div>

一般情况下你可以相信Spring在做正确的事。它在容器加载时检测配置问题，例如对不存在的bean的引用和循环依赖。当实际创建bean时，
Spring会尽可能晚地设置属性并解析依赖关系。这意味着当您请求对象时，如果在创建该对象或其依赖项之一时出现问题，Spring容器（已正确加载）可以延迟生成异常--例如，bean因缺少属性或无效属性而抛出异常。
这可能会延迟一些配置问题的可见性，这就是默认情况下`ApplicationContext`实现预先实例化单例bean的原因。以实际需要之前创建这些bean的一些前期时间和内存为代价，您在创建ApplicationContext时发现配置问题，而不会延迟。
但是仍然可以覆盖此默认行为，以便单例bean可以懒惰地初始化，而不是预先实例化（前提是你的配置是没有错误）。

如果不存在循环依赖问题，当一个或多个协作bean被注入依赖bean时，每个协作bean在被注入依赖bean之前完全配置。
这意味着，如果bean A依赖于bean B，则Spring IoC容器在调用bean A上的setter方法之前完全配置bean B。
换句话说，先实例化bean（如果它不是预先实例化的单例），然后设置其依赖项，最后调用相关的生命周期方法（例如配置的[init](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-lifecycle-initializingbean)方法或[InitializingBean](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-lifecycle-initializingbean)回调方法）。

##### 依赖注入的示例
以下示例将基于XML的配置元数据用于基于setter的DI。 Spring XML配置文件的一小部分指定了一些bean定义，如下所示：
```
<bean id="exampleBean" class="examples.ExampleBean">
    <!-- setter injection using the nested ref element -->
    <property name="beanOne">
        <ref bean="anotherExampleBean"/>
    </property>

    <!-- setter injection using the neater ref attribute -->
    <property name="beanTwo" ref="yetAnotherBean"/>
    <property name="integerProperty" value="1"/>
</bean>

<bean id="anotherExampleBean" class="examples.AnotherBean"/>
<bean id="yetAnotherBean" class="examples.YetAnotherBean"/>
```
以下示例显示了相应的ExampleBean类：
```
public class ExampleBean {

    private AnotherBean beanOne;

    private YetAnotherBean beanTwo;

    private int i;

    public void setBeanOne(AnotherBean beanOne) {
        this.beanOne = beanOne;
    }

    public void setBeanTwo(YetAnotherBean beanTwo) {
        this.beanTwo = beanTwo;
    }

    public void setIntegerProperty(int i) {
        this.i = i;
    }
}
```

在前面的示例中，声明setter与XML文件中指定的属性匹配。以下示例使用基于构造函数的DI：
```
<bean id="exampleBean" class="examples.ExampleBean">
    <!-- constructor injection using the nested ref element -->
    <constructor-arg>
        <ref bean="anotherExampleBean"/>
    </constructor-arg>

    <!-- constructor injection using the neater ref attribute -->
    <constructor-arg ref="yetAnotherBean"/>

    <constructor-arg type="int" value="1"/>
</bean>

<bean id="anotherExampleBean" class="examples.AnotherBean"/>
<bean id="yetAnotherBean" class="examples.YetAnotherBean"/>
```
以下示例显示了相应的ExampleBean类：
```
public class ExampleBean {

    private AnotherBean beanOne;

    private YetAnotherBean beanTwo;

    private int i;

    public ExampleBean(
        AnotherBean anotherBean, YetAnotherBean yetAnotherBean, int i) {
        this.beanOne = anotherBean;
        this.beanTwo = yetAnotherBean;
        this.i = i;
    }
}
```
bean定义中指定的构造函数参数用作ExampleBean的构造函数的参数。

现在考虑这个例子的变体，其中，不是使用构造函数，而是告诉Spring调用静态工厂方法来返回对象的实例：
```
<bean id="exampleBean" class="examples.ExampleBean" factory-method="createInstance">
    <constructor-arg ref="anotherExampleBean"/>
    <constructor-arg ref="yetAnotherBean"/>
    <constructor-arg value="1"/>
</bean>

<bean id="anotherExampleBean" class="examples.AnotherBean"/>
<bean id="yetAnotherBean" class="examples.YetAnotherBean"/>
```
以下示例显示了相应的ExampleBean类：
```
public class ExampleBean {

    // a private constructor
    private ExampleBean(...) {
        ...
    }

    // a static factory method; the arguments to this method can be
    // considered the dependencies of the bean that is returned,
    // regardless of how those arguments are actually used.
    public static ExampleBean createInstance (
        AnotherBean anotherBean, YetAnotherBean yetAnotherBean, int i) {

        ExampleBean eb = new ExampleBean (...);
        // some other operations...
        return eb;
    }
}
```
静态工厂方法的参数由<constructor-arg />元素提供，与构造函数完全相同。工厂方法返回的类的类型不必与静态工厂类相同（尽管在本例中，它是一样的）。
实例（非静态）工厂方法可以以基本相同的方式使用（除了使用factory-bean属性而不是class属性），因此我们不在这里讨论这些细节。

#### 1.4.2 依赖关系和配置的细节
如上一节所述，您可以将bean属性和构造函数参数定义为对其他托管bean（协作者）的引用，也可以将其定义为内联定义的值。为此，Spring的基于XML的配置元数据支持其`<property />`和`<constructor-arg />`元素中的子元素类型。

##### 直值（基元，字符串等）(Straight Values (Primitives, Strings, and so on))
`<property />`元素的`value`属性将属性或构造函数参数指定为人类可读的字符串表示形式。Spring的转换服务（[conversion service](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#core-convert-ConversionService-API)）
用于将这些值从String转换为属性或参数的实际类型。以下示例显示了要设置的各种值：
```
<bean id="myDataSource" class="org.apache.commons.dbcp.BasicDataSource" destroy-method="close">
    <!-- results in a setDriverClassName(String) call -->
    <property name="driverClassName" value="com.mysql.jdbc.Driver"/>
    <property name="url" value="jdbc:mysql://localhost:3306/mydb"/>
    <property name="username" value="root"/>
    <property name="password" value="masterkaoli"/>
</bean>
```
以下示例使用p命名空间进行更简洁的XML配置:
```
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:p="http://www.springframework.org/schema/p"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
    https://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="myDataSource" class="org.apache.commons.dbcp.BasicDataSource"
        destroy-method="close"
        p:driverClassName="com.mysql.jdbc.Driver"
        p:url="jdbc:mysql://localhost:3306/mydb"
        p:username="root"
        p:password="masterkaoli"/>

</beans>
```
前面的XML更简洁。但是，除非您在创建bean定义时使用支持自动属性完成的IDE（例如IntelliJ IDEA或Spring Tool Suite），否则会在运行时而不是设计时发现拼写错误。强烈建议使用此类IDE帮助。

您还可以配置`java.util.Properties`实例，如下所示：
```
<bean id="mappings"
    class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer">

    <!-- typed as a java.util.Properties -->
    <property name="properties">
        <value>
            jdbc.driver.className=com.mysql.jdbc.Driver
            jdbc.url=jdbc:mysql://localhost:3306/mydb
        </value>
    </property>
</bean>
```
Spring容器通过使用JavaBeans `PropertyEditor`机制将`<value />`元素内的文本转换为`java.util.Properties`实例。
这是一个很好的快捷方式，并且是Spring团队支持在值属性样式上使用嵌套`<value />`元素的一些地方之一。

##### The idref element
`idref`元素只是一种防错方法，可以将容器中另一个bean的id（字符串值 - 而不是引用）传递给`<constructor-arg />`或`<property />`元素。以下示例显示了如何使用它：
```
<bean id="theTargetBean" class="..."/>

<bean id="theClientBean" class="...">
    <property name="targetName">
        <idref bean="theTargetBean"/>
    </property>
</bean>
```
前面的bean定义代码段与以下代码段完全等效（在运行时）：
```
<bean id="theTargetBean" class="..." />

<bean id="client" class="...">
    <property name="targetName" value="theTargetBean"/>
</bean>
```
第一种形式优于第二种形式，因为使用`idref`标记允许容器在部署时验证引用的命名bean实际存在(部属时就校验`targetName`是否存在)。在第二个变体中，不对传递给`client`bean的`targetName`属性的值执行验证。当客户端bean实际被实例化时，
才会发现错别字（最有可能致命的结果）。如果`client`bean是 prototype bean，则只能在部署容器后很长时间才能发现此错误和产生的异常。

> 4.0 beans XSD中不再支持idref元素的local属性，因为它不再提供常规bean引用的值。升级到4.0架构时，将现有的idref local引用更改为idref bean。

`<idref />`元素带来值的常见位置（至少在Spring 2.0之前的版本中）是在`ProxyFactoryBean` bean定义中的AOP拦截器的配置中。指定拦截器名称时使用`<idref />`元素可以防止拼写错误的拦截器ID。

##### 参考其他bean（合作者（被注入的依赖bean））
ref元素是`<constructor-arg />`或`<property />`定义元素中的最后一个元素。在这里，您将bean的指定属性的值设置为对容器管理的另一个bean（协作者）的引用。
被注入的依赖bea在设置该属性之前根据需要按需初始化它。（如果被注入依赖是单例的，则他可能已由容器初始化）。所有引用最终都是对另一个对象的引用。
范围和验证取决于您是通过`bean`，`local`或`parent`属性指定其他对象的ID还是名称。

通过`<ref />`标记的`bean`属性指定目标bean是最常用的形式，并允许创建对同一容器或父容器中的任何bean的引用，而不管它是否在同一XML文件中。
bean属性的值可以与目标bean的id属性相同，也可以与目标bean的name属性中的值之一相同。以下示例显示如何使用ref元素：
```
<ref bean="someBean"/>
```
通过`parent`属性指定目标bean会创建对当前容器的父容器中的`bean`的引用。`parent`属性的值可以与目标bean的`id`属性或目标bean的`name`属性中的值之一相同。
目标bean必须位于当前bean的父容器中。您应该使用此bean引用变体，主要是在您具有容器层次结构并且希望将现有bean包装在父容器中，并使用与父bean具有相同名称的代理。
以下一对列表显示了如何使用父属性：
```
<!-- in the parent context -->
<bean id="accountService" class="com.something.SimpleAccountService">
    <!-- insert dependencies as required as here -->
</bean>
```
```
<!-- in the child (descendant) context -->
<bean id="accountService" <!-- bean name is the same as the parent bean -->
    class="org.springframework.aop.framework.ProxyFactoryBean">
    <property name="target">
        <ref parent="accountService"/> <!-- notice how we refer to the parent bean -->
    </property>
    <!-- insert other configuration and dependencies as required here -->
</bean>
```

##### Inner Beans (内部类)
`<property />`或`<constructor-arg />`元素中的`<bean />`元素定义了内部bean，如下例所示：
```
<bean id="outer" class="...">
    <!-- instead of using a reference to a target bean, simply define the target bean inline -->
    <property name="target">
        <bean class="com.example.Person"> <!-- this is the inner bean -->
            <property name="name" value="Fiona Apple"/>
            <property name="age" value="25"/>
        </bean>
    </property>
</bean>
```
内部bean定义不需要定义的ID或名称。如果指定，则容器不使用此类值作为标识符。容器还会在创建时忽略scope标志，因为内部bean始终是匿名的，并且始终使用外部bean创建。
不可能独立访问内部bean或将它们注入协作bean而不是封闭bean。

作为一个极端情况，可以从自定义范围接收销毁回调 - 例如，对于包含在单例bean中的请求范围内部bean。

##### 集合
`<list />`，`<set />`，`<map />`和`<props />`元素分别设置Java Collection类型List，Set，Map和Properties的属性和参数。以下示例显示了如何使用它们：
```
<bean id="moreComplexObject" class="example.ComplexObject">
    <!-- results in a setAdminEmails(java.util.Properties) call -->
    <property name="adminEmails">
        <props>
            <prop key="administrator">administrator@example.org</prop>
            <prop key="support">support@example.org</prop>
            <prop key="development">development@example.org</prop>
        </props>
    </property>
    <!-- results in a setSomeList(java.util.List) call -->
    <property name="someList">
        <list>
            <value>a list element followed by a reference</value>
            <ref bean="myDataSource" />
        </list>
    </property>
    <!-- results in a setSomeMap(java.util.Map) call -->
    <property name="someMap">
        <map>
            <entry key="an entry" value="just some string"/>
            <entry key ="a ref" value-ref="myDataSource"/>
        </map>
    </property>
    <!-- results in a setSomeSet(java.util.Set) call -->
    <property name="someSet">
        <set>
            <value>just some string</value>
            <ref bean="myDataSource" />
        </set>
    </property>
</bean>
```
map的键或值的值或set的值也可以是以下任何元素：

    bean | ref | idref | list | set | map | props | value | null

##### 集合合并
Spring容器还支持合并集合。应用程序开发人员可以定义父`<list />`，`<map />`，`<set />`或`<props />`元素，并具有子`<list />`，`<map />`，`<set />`或`<props />`元素继承和覆盖父集合中的值。
也就是说，子集合的值是合并父集合和子集合的元素的结果，子集合的元素覆盖父集合中指定的值。

关于合并的这一部分讨论了父子bean机制。不熟悉父母和子bean定义的读者可以在先阅读[相关部分](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-child-bean-definitions)。

以下示例演示了集合合并：
```
<beans>
    <bean id="parent" abstract="true" class="example.ComplexObject">
        <property name="adminEmails">
            <props>
                <prop key="administrator">administrator@example.com</prop>
                <prop key="support">support@example.com</prop>
            </props>
        </property>
    </bean>
    <bean id="child" parent="parent">
        <property name="adminEmails">
            <!-- the merge is specified on the child collection definition -->
            <props merge="true">
                <prop key="sales">sales@example.com</prop>
                <prop key="support">support@example.co.uk</prop>
            </props>
        </property>
    </bean>
<beans>
```

请注意在子bean定义的`adminEmails`属性的`<props />`元素上使用`merge = true`属性。chlid bean 将包含parent和child中的所有属性，即
```
administrator=administrator@example.com
sales=sales@example.com
support=support@example.co.uk
```

子属性集合的值集继承父`<props />`中的所有属性元素，子值的支持值将覆盖父集合中的值。

此合并行为同样适用于`<list />`，`<map />`和`<set />`集合类型。在使用`<list />`元素时，会有集合排序问题，与定义时的顺序一致（即，有序的值集合的概念）。父级的值位于所有子级列表的值之前。
对于Map，Set和Properties集合类型，不存在排序。因此，对于作为容器在内部使用的关联Map，Set和Properties实现类型的基础的集合类型，没有排序问题。

##### 强类型集合（Strongly-typed collection）
通过在Java 5中引入泛型类型，您可以使用强类型集合。也就是说，可以声明Collection类型，使其只能包含（例如）String元素。
如果你使用Spring依赖注入一个强类型的Collection到bean中，您可以利用Spring的类型转换支持，以便强类型Collection实例的元素在添加到Collection之前转换为适当的类型。
以下Java类和bean定义显示了如何执行此操作：
```
public class SomeClass {

    private Map<String, Float> accounts;

    public void setAccounts(Map<String, Float> accounts) {
        this.accounts = accounts;
    }
}

<beans>
    <bean id="something" class="x.y.SomeClass">
        <property name="accounts">
            <map>
                <entry key="one" value="9.99"/>
                <entry key="two" value="2.75"/>
                <entry key="six" value="3.99"/>
            </map>
        </property>
    </bean>
</beans>
```

##### NULL值和空字符串值
Spring将属性等的空参数视为空字符串。以下基于XML的配置元数据片段将`email`属性设置为空String值（“”）。
```
<bean class="ExampleBean">
    <property name="email" value=""/>
</bean>
```
上面的示例等效于以下Java代码：
```
exampleBean.setEmail("");
```

`<null />`元素处理NULL值。以下清单显示了一个示例：
```
<bean class="ExampleBean">
    <property name="email">
        <null/>
    </property>
</bean>
```
上述配置等同于以下Java代码：
```
exampleBean.setEmail(null);
```

##### 带有p命名空间的XML快捷方式
p-namespace允许您使用bean元素的属性（而不是嵌套的`<property />`元素）来描述属性值协作bean，或两者。
Spring支持具有命名空间的可扩展配置格式，这些命名空间基于XML Schema定义。本章中讨论的bean配置格式在XML Schema文档中定义。但是，p-namespace未在XSD文件中定义，仅存在于Spring的核心中。

以下示例显示了两个XML片段（第一个使用标准XML格式，第二个使用p命名空间）解析为相同的结果：
```
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:p="http://www.springframework.org/schema/p"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean name="classic" class="com.example.ExampleBean">
        <property name="email" value="someone@somewhere.com"/>
    </bean>

    <bean name="p-namespace" class="com.example.ExampleBean"
        p:email="someone@somewhere.com"/>
</beans>
```
该示例显示了bean定义中名为email的p命名空间中的属性。这告诉Spring包含一个属性声明。如前所述，p命名空间没有schema定义，因此您可以将属性的名称设置为属性名称。

下一个示例包括另外两个bean定义，它们都引用了另一个bean：
```
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:p="http://www.springframework.org/schema/p"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean name="john-classic" class="com.example.Person">
        <property name="name" value="John Doe"/>
        <property name="spouse" ref="jane"/>
    </bean>

    <bean name="john-modern"
        class="com.example.Person"
        p:name="John Doe"
        p:spouse-ref="jane"/>

    <bean name="jane" class="com.example.Person">
        <property name="name" value="Jane Doe"/>
    </bean>
</beans>
```
此示例不仅包含使用p命名空间的属性值，还使用特殊格式来声明属性引用。
第一个bean定义使用<property name =“spouse”ref =“jane”/>来创建从bean john到bean jane的引用，而第二个bean定义使用p：spouse-ref =“jane”作为要执行的属性完全相同的事情。
在这个案例中，`spouse`是属性名称，而-ref部分表示这不是直接值，而是对另一个bean的引用。

> p命名空间不如标准XML格式灵活。例如，声明属性引用的格式与以Ref结尾的属性冲突，而标准XML格式则不然。我们建议您仔细选择您的方法并将其传达给您的团队成员，以避免生成同时使用所有三种方法的XML文档。

##### 带有c命名空间的XML快捷方式 （构造方法）
与带有p-namespace的XML Shortcut类似，Spring 3.1中引入的c-namespace允许使用内联属性来配置构造函数参数，而不是嵌套的constructor-arg元素。

以下示例使用c：namespace来执行与基于构造函数的依赖注入相同的操作：
```
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:c="http://www.springframework.org/schema/c"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="beanTwo" class="x.y.ThingTwo"/>
    <bean id="beanThree" class="x.y.ThingThree"/>

    <!-- traditional declaration with optional argument names -->
    <bean id="beanOne" class="x.y.ThingOne">
        <constructor-arg name="thingTwo" ref="beanTwo"/>
        <constructor-arg name="thingThree" ref="beanThree"/>
        <constructor-arg name="email" value="something@somewhere.com"/>
    </bean>

    <!-- c-namespace declaration with argument names -->
    <bean id="beanOne" class="x.y.ThingOne" c:thingTwo-ref="beanTwo"
        c:thingThree-ref="beanThree" c:email="something@somewhere.com"/>

</beans>
```
`c:`名称空间使用与`p:`one（bean引用的尾随-ref）相同的约定，用于按名称设置构造函数参数。类似地，它需要在XML文件中声明，即使它没有在XSD模式中定义（它存在于Spring核心内部）。

对于构造函数参数名称不可用的罕见情况（通常在没有调试信息的情况下编译字节码），您可以使用回退到参数索引，如下所示：
```
<!-- c-namespace index declaration -->
<bean id="beanOne" class="x.y.ThingOne" c:_0-ref="beanTwo" c:_1-ref="beanThree"
    c:_2="something@somewhere.com"/>
```
> 由于XML语法，索引表示法要求存在前导_，因为XML属性名称不能以数字开头（即使某些IDE允许）。对于`<constructor-arg>`元素也可以使用相应的索引表示法，但不常用，因为声明的简单顺序通常就足够了。

实际上，构造函数解析机制在匹配参数方面非常有效，因此除非您确实需要，否则我们建议在整个配置中使用名称表示法而不是索引。

##### 复合属性名称 （Compound Property Names）
只要除最终属性名称之外的路径的所有组件都不为null，您可以在设置bean属性时使用复合或嵌套属性名称。考虑以下bean定义：
```
<bean id="something" class="things.ThingOne">
    <property name="fred.bob.sammy" value="123" />
</bean>
```
这个bean有一个`fred`属性，它有一个`bob`属性，它有一个`sammy`属性，最终的`sammy`属性被设置为`123`。
为了使它能够工作，在构造bean之后，`something`的`fred`属性和`fred`的`bob`属性不能为null。否则，抛出NullPointerException。

##### 使用`depends-on`
如果bean是另一个bean的依赖项，那通常意味着将一个bean设置为另一个bean的属性。通常，您可以使用基于XML的配置元数据中的`<ref />`元素来完成此操作。但是，有时bean之间的依赖关系不那么直接。
例如，需要触发类中的静态初始化程序，例如数据库驱动程序注册。depends-on属性可以显式强制初始化一个或多个bean，在初始化使用此元素的bean之前。
以下示例使用depends-on属性表示对单个bean的依赖关系：
```
<bean id="beanOne" class="ExampleBean" depends-on="manager"/>
<bean id="manager" class="ManagerBean" />
```
要表示对多个bean的依赖关系，请提供bean名称列表作为depends-on属性的值（逗号，空格和分号是有效的分隔符）：
```
<bean id="beanOne" class="ExampleBean" depends-on="manager,accountDao">
    <property name="manager" ref="manager" />
</bean>

<bean id="manager" class="ManagerBean" />
<bean id="accountDao" class="x.y.jdbc.JdbcAccountDao" />
```
> `depends-on`属性既可以指定初始化时间依赖性，也可以指定单独的bean，相应的销毁时间依赖性。在给定的bean本身被销毁之前，首先销毁定义与给定bean的依赖关系的从属bean。因此，依赖也可以控制关​​闭顺序。

##### 延迟加载
默认情况下，`ApplicationContext`实现会急切地创建和配置所有单例bean，作为初始化过程的一部分。通常，这种预先实例化是可取的，因为配置或周围环境中的错误是立即发现的，而不是几小时甚至几天后。
当不希望出现这种情况时，可以通过将bean定义标记为延迟初始化来阻止单例bean的预实例化。延迟初始化的bean告诉IoC容器在第一次请求时创建bean实例，而不是在启动时。

在XML中，此行为由`<bean />`元素上的`lazy-init`属性控制，如以下示例所示：
```
<bean id="lazy" class="com.something.ExpensiveToCreateBean" lazy-init="true"/>
<bean name="not.lazy" class="com.something.AnotherBean"/>
```
当`ApplicationContext`使用前面的配置时，在`ApplicationContext`启动时不会急切地预先实例化lazy bean，而是急切地预先实例化not.lazy bean。
但是，当延迟初始化的bean是未延迟初始化的单例bean的依赖项时，ApplicationContext会在启动时创建延迟初始化的bean，因为它必须满足单例的依赖关系。惰性初始化的bean被注入到其他地方的单独的bean中，而这个bean并不是惰性初始化的。

您还可以使用`<beans />`元素上的`default-lazy-init`属性在容器级别控制延迟初始化，以下示例显示：
```
<beans default-lazy-init="true">
    <!-- no beans will be pre-instantiated... -->
</beans>
```

#### 1.4.5 自动装配依赖(Autowiring Collaborators)
Spring容器可以自动连接协作bean之间的关系。您可以通过检查ApplicationContext的内容让Spring自动为您的bean解析协作者（其他bean）。自动装配具有以下优点：

* 自动装配可以显着减少对指定属性或构造函数参数的需要。（[在本章其他地方](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-child-bean-definitions)讨论的其他机制，如bean模板，在这方面也很有价值。）
* 自动装配可以随着对象的发展更新配置。例如，如果需要向类添加依赖项，则可以自动满足该依赖项，而无需修改配置。因此，自动装配在开发期间尤其有用，而不会在代码库变得更稳定时否定切换到显式布线的选项。

使用基于XML的配置元数据（请参阅依赖注入）时，可以使用<bean />元素的autowire属性为bean定义指定autowire模式。自动装配功能有四种模式。您指定每个bean的自动装配，因此可以选择要为哪些bean进行自动装配。下表描述了四种自动装配模式：

Mode|Explanation
--|:--
no|（默认）无自动装配。Bean引用必须由ref元素定义。不建议对较大的部署更改默认设置，因为明确指定协作者可以提供更好的控制和清晰度。在某种程度上，它记录了系统的结构。
byName|按属性名称自动装配。 Spring查找与需要自动装配的属性同名的bean。例如，如果bean定义按名称设置为autowire并且它包含master属性（即，它具有setMaster（..）方法），则Spring会查找名为master的bean定义并使用它来设置属性。
byType|如果容器中只存在一个属性类型的bean，则允许属性自动装配。如果存在多个，则抛出致命异常，这表示您不能对该bean使用byType自动装配。如果没有匹配的bean，则不会发生任何事情（该属性未设置）。
constructor|类似于byType但适用于构造函数参数。如果容器中没有构造函数参数类型的一个bean，则会引发致命错误。

使用byType或构造函数自动装配模式，您可以连接数组和类型集合。在这种情况下，提供容器内与预期类型匹配的所有autowire候选者以满足依赖性。如果预期的键类型是String，则可以自动装配强类型的Map实例。
自动装配的Map实例的值由与预期类型匹配的所有Bean实例组成，Map实例的键包含相应的bean名称。

##### 自动装配的局限和缺点
当在整个项目中一致地使用自动装配时，自动装配效果最佳。如果一般不使用自动装配，那么开发人员使用它来连接一个或两个bean定义可能会让人感到困惑。
考虑自动装配的局限和缺点：

* property和constructor-arg设置中的显式依赖项始终覆盖自动装配。您不能自动装配简单属性，例如基元(基本类型)，字符串和类（以及此类简单属性的数组）。这种限制是按设计的。
* 自动装配不如显式ref精确。虽然如前面的表中所述，但Spring会谨慎地避免在可能产生意外结果的模糊性的情况下进行猜测。您不再明确记录Spring管理对象之间的关系。
* 可能无法为可能从Spring容器生成文档的工具提供接线信息。
* 容器中的多个bean定义可以匹配setter方法或构造函数参数指定的类型以进行自动装配。对于数组，集合或Map实例，这不一定是个问题。但是，对于期望单个值的依赖关系，这种模糊性不是任意解决的。如果没有可用的唯一bean定义，则抛出异常。

在后一种情况下，您有几种选择：

* 放弃自动装配，支持显式布线。
* 通过将autowire-candidate属性设置为false，避免对bean定义进行自动装配，如[下一节](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-autowire-candidate)所述。
* 通过将其`<bean />`元素的`primary`属性设置为`true`，将single bean定义指定为主要候选者。
* 实现基于注释的配置可用的更细粒度的控件，如[基于注释](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-annotation-config)的容器配置中所述。

###### 从自动装配中排除Bean
在每个bean的基础上，您可以从自动装配中排除bean。在Spring的XML格式中，将`<bean />`元素的`autowire-candidate`属性设置为false。容器使特定的bean定义对自动装配基础结构不可用（包括注释样式配置，如`@Autowired`）。

> autowire-candidate属性仅影响基于类型的自动装配。它不会影响名称的显式引用，即使指定的bean的autowire candidate=false，也会解析它。因此，如果名称匹配，则按名称自动装配会注入bean。
> 也就时说，如果是按name匹配，则会忽略autowire-candidate属性

您还可以根据与bean名称的模式匹配来限制autowire候选者。顶级`<beans />`元素在其`default-autowire-candidates`属性中接受一个或多个模式。例如，要将autowire候选状态限制为名称以Repository结尾的任何bean，请提供值`*Repository`。
多个用逗号隔开。bean定义的`autowire-candidate`属性的显式值`true`或`false`始终优先。对于此类bean，模式匹配规则不适用。也就是说只有`default-autowire-candidates`匹配的才能成为自动装配，但`autowire-candidate`的优先级要比
`default-autowire-candidates`高。

这些技术对于您永远不希望通过自动装配注入其他bean的bean非常有用。这并不意味着排除的bean本身不能使用自动装配进行配置。相反，bean本身不是自动装配其他bean的候选者。**也就是说，非候选者的bean，他自己还是可以使用自动装配。**

<h4 id="1.4.6">1.4.6 方法注入</h4>

在大多数应用程序场景中，容器中的大多数bean都是单例。当单例bean需要与另一个单例bean协作或非单例bean需要与另一个非单例bean协作时，通常通过将一个bean定义为另一个bean的属性来处理依赖关系。
当bean生命周期不同时会出现问题。假设单例bean A需要使用非单例（prototype）bean B，可能是在A上的每个方法调用上。容器只创建一次单独的bean A，因此只有一次机会来设置属性。
每次需要时，容器都不能为bean A提供bean B的新实例。

一个解决方案是放弃一些控制反转。您可以通过实现ApplicationContextAware接口使bean A了解容器，并通过对容器进行getBean（“B”）调用，每次bean A需要时都要求（通常是新的）bean B实例。以下示例显示了此方法：
```
// a class that uses a stateful Command-style class to perform some processing
package fiona.apple;

// Spring-API imports
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

public class CommandManager implements ApplicationContextAware {

    private ApplicationContext applicationContext;

    public Object process(Map commandState) {
        // grab a new instance of the appropriate Command
        Command command = createCommand();
        // set the state on the (hopefully brand new) Command instance
        command.setState(commandState);
        return command.execute();
    }

    protected Command createCommand() {
        // notice the Spring API dependency!
        return this.applicationContext.getBean("command", Command.class);
    }

    public void setApplicationContext(
            ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }
}
```
前面的内容是不可取的，因为业务代码知道并耦合到Spring Framework。方法注入是Spring IoC容器的一个高级功能，可以让您干净地处理这个用例。

    您可以在此[博客](https://spring.io/blog/2004/08/06/method-injection/)条目中阅读有关Method Injection的动机的更多信息。

##### 查找方法注入
查找方法注入是容器覆盖容器管理的bean上的方法并返回容器中另一个命名bean的查找结果的能力。查找通常涉及prototype bean，如上一节中描述的场景。
Spring Framework通过使用CGLIB库中的字节码生成来动态生成覆盖该方法的子类来实现此方法注入。

> * 为了使这个动态子类工作，Spring bean容器子类不能是final的类，要覆盖的方法也不能是final。
> * 对具有抽象方法的类进行单元测试需要您自己对类进行子类化，并提供抽象方法的存根实现。
> * 组件扫描也需要具体的方法，这需要具体的类来获取。
> * 另一个关键限制是查找方法不适用于工厂方法，特别是配置类中的@Bean方法。在这种情况下，容器不负责创建实例，因此无法动态创建运行时生成的子类。

对于前面代码片段中的CommandManager类，Spring容器动态地覆盖createCommand（）方法的实现。CommandManager类没有任何Spring依赖项，因为重写的示例显示：
```
package fiona.apple;

// no more Spring imports!

public abstract class CommandManager {

    public Object process(Object commandState) {
        // grab a new instance of the appropriate Command interface
        Command command = createCommand();
        // set the state on the (hopefully brand new) Command instance
        command.setState(commandState);
        return command.execute();
    }

    // okay... but where is the implementation of this method?
    protected abstract Command createCommand();
}
```
在包含要注入的方法的客户机类（在本例中为CommandManager）中，要注入的方法需要以下形式的签名：

    <public|protected> [abstract] <return-type> theMethodName(no-arguments);

如果方法是抽象的，则动态生成的子类实现该方法。否则，动态生成的子类将覆盖原始类中定义的具体方法。请考虑以下示例：
```
<!-- a stateful bean deployed as a prototype (non-singleton) -->
<bean id="myCommand" class="fiona.apple.AsyncCommand" scope="prototype">
    <!-- inject dependencies here as required -->
</bean>

<!-- commandProcessor uses statefulCommandHelper -->
<bean id="commandManager" class="fiona.apple.CommandManager">
    <lookup-method name="createCommand" bean="myCommand"/>
</bean>
```
标识为`commandManager`的bean在需要`myCommand` bean的新实例时调用自己的`createCommand()`方法。如果实际需要，您必须小心将`myCommand` bean部署为原型。如果它是单例，则每次都返回myCommand bean的相同实例。

或者，在基于注释的组件模型中，您可以通过@Lookup注释声明查找方法，如以下示例所示：
```
public abstract class CommandManager {

    public Object process(Object commandState) {
        Command command = createCommand();
        command.setState(commandState);
        return command.execute();
    }

    @Lookup("myCommand")
    protected abstract Command createCommand();
}
```
或者，更普遍的用法，您可以依赖于针对查找方法的声明返回类型解析目标bean：
```
public abstract class CommandManager {

    public Object process(Object commandState) {
        MyCommand command = createCommand();
        command.setState(commandState);
        return command.execute();
    }

    @Lookup
    protected abstract MyCommand createCommand();
}
```

请注意，您通常应该使用具体的存根实现来声明这种带注释的查找方法，为了使它们与Spring的组件扫描规则兼容，默认情况下抽象类被忽略。此限制不适用于显式注册或显式导入的bean类。

> 访问不同范围的目标bean的另一种方法是ObjectFactory / Provider注入点。[请参阅Scoped Beans作为依赖关系](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-scopes-other-injection）。
> 您可能还会发现ServiceLocatorFactoryBean（在org.springframework.beans.factory.config包中）很有用。

##### 任意方法替换
与查找方法注入相比，一种不太有用的方法注入形式是使用另一个方法实现替换托管bean中的任意方法。您可以安全地跳过本节的其余部分，直到您确实需要此功能。

使用基于XML的配置元数据，您可以使用`replaced-method`元素将已有的方法实现替换为已部署的bean。考虑以下类，它有一个我们想要覆盖的名为`computeValue`的方法：
```
public class MyValueCalculator {

    public String computeValue(String input) {
        // some real code...
    }

    // some other methods...
}
```
实现`org.springframework.beans.factory.support.MethodReplacer`接口的类提供了新的方法定义，如以下示例所示：
```
/**
 * meant to be used to override the existing computeValue(String)
 * implementation in MyValueCalculator
 */
public class ReplacementComputeValue implements MethodReplacer {

    public Object reimplement(Object o, Method m, Object[] args) throws Throwable {
        // get the input value, work with it, and return a computed result
        String input = (String) args[0];
        ...
        return ...;
    }
}
```
部署原始类并指定方法覆盖的bean定义类似于以下示例：
```
<bean id="myValueCalculator" class="x.y.z.MyValueCalculator">
    <!-- arbitrary method replacement -->
    <replaced-method name="computeValue" replacer="replacementComputeValue">
        <arg-type>String</arg-type>
    </replaced-method>
</bean>

<bean id="replacementComputeValue" class="a.b.c.ReplacementComputeValue"/>
```

被替换后的类不在执行`MyValueCalculator`中的computeValue方法，而是执行`ReplacementComputeValue`中`reimplement`方法。

您可以在`<replacement-method />`元素中使用一个或多个`<arg-type />`元素来指示被覆盖的方法的方法签名。仅当方法重载且类中存在多个变体时，才需要参数的签名。
为方便起见，参数的类型字符串可以是完全限定类型名称的子字符串。例如，以下所有匹配java.lang.String：
```
java.lang.String
String
St
```
因为参数的数量通常足以区分每种可能的选择，通过让您只键入与参数类型匹配的最短字符串，此快捷方式可以节省大量输入。

<h3 id="1.5">1.5 Bean范围 （Bean Scopes）</h3>
创建bean定义时，可以创建用于创建由该bean定义定义的类的实际实例的配方。bean定义是一个配方的想法很重要，因为它意味着，与一个类一样，您可以从一个配方创建许多对象实例。

您不仅可以控制要插入到从特定bean定义创建的对象中的各种依赖项和配置值，还可以控制从特定bean定义创建的对象的范围。这种方法功能强大且灵活，因为您可以选择通过配置创建的对象的范围，而不必在Java类级别设置对象的范围。
可以将Bean定义为部署在多个范围之一中。Spring Framework支持六个范围，只有在使用支持Web的ApplicationContext时才有四个范围可用。您还可以创建[自定义范围](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-scopes-custom)。

下表描述了支持的范围：

*Table 3. Bean scopes*

Scope|Description
--|:--
singleton|（默认）将单个bean定义范围限定为每个Spring IoC容器的单个对象实例。
prototype| 将单个bean定义范围限定为任意数量的对象实例。
request| 将单个bean定义范围限定为单个HTTP请求的生命周期。也就是说，每个HTTP请求都有自己的bean实例，它是在单个bean定义的后面创建的。仅在Web感知Spring ApplicationContext的上下文中有效(Only valid in the context of a web-aware Spring ApplicationContext.)。
session| 将单个bean定义范围限定为HTTP会话的生命周期。仅在Web感知Spring ApplicationContext的上下文中有效。
application| 将单个bean定义限定为ServletContext的生命周期。仅在Web感知Spring ApplicationContext的上下文中有效。
[websocket](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/web.html#websocket-stomp-websocket-scope)| 将单个bean定义范围限定为WebSocket的生命周期。仅在Web感知Spring ApplicationContext的上下文中有效。

> 从Spring 3.0开始，线程范围可用，但默认情况下未注册：请参阅SimpleThreadScope。从Spring 4.2开始，也可以使用事务范围：SimpleTransactionScope。有关如何注册这些或任何其他自定义作用域的说明，请参阅使用[自定义作用域](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-scopes-custom-using)。

#### 1.5.1 单例
只管理单个bean的一个共享实例，并且对具有与该bean定义匹配的ID或ID的bean的所有请求都会导致Spring容器返回一个特定的bean实例。

换句话说，当您定义一个bean definition并将其作为单一作用域时，Spring IoC容器只创建该bean definition定义的对象的一个​​实例。此单个实例存储在此类单例bean的缓存中，并且该命名Bean的所有后续请求和引用都将返回缓存对象。
下图显示了单例范围的工作原理：

![](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/images/singleton.png)

Spring的单例bean概念不同于Gang of Four（GoF）模式书中定义的单例模式。GoF单例对一个对象的范围进行硬编码，使得每个ClassLoader创建一个且只有一个特定类的实例。Spring单例的范围最好描述为每容器和每个bean(也就是说spring中一个类
可以被定义为多个bean，每个bean是单例的，并不是说该类是单例的；而且每个容器中也可以有想同的bean)。这意味着，如果在单个Spring容器中为特定类定义一个bean，则Spring容器将创建该bean definition所定义的类的一个且仅一个实例。
单例范围是Spring中的默认范围。要将bean定义为XML中的单例，您可以定义一个bean，如以下示例所示：
```
<bean id="accountService" class="com.something.DefaultAccountService"/>

<!-- the following is equivalent, though redundant (singleton scope is the default) -->
<bean id="accountService" class="com.something.DefaultAccountService" scope="singleton"/>
```

#### 1.5.2 The Prototype Scope
bean部署的非单例原型范围导致每次发出对该特定bean的请求时都创建新的bean实例。也就是说，bean被注入另一个bean，或者通过对容器的getBean（）方法调用来请求它。通常，您应该对所有有状态bean使用原型范围，对无状态bean使用单例范围。

下图说明了Spring原型范围：

![](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/images/prototype.png)

（数据访问对象（DAO）通常不配置为原型，因为典型的DAO不会保持任何会话状态。我们更容易重用单例图的核心。）

以下示例将bean定义为XML中的原型：

```
<bean id="accountService" class="com.something.DefaultAccountService" scope="prototype"/>
```
与其他范围相比，Spring不管理原型bean的完整生命周期。容器实例化，配置和组装原型对象并将其交给客户端，没有该原型实例的进一步记录。
因此，尽管无论范围如何都在所有对象上调用初始化生命周期回调方法，但在原型的情况下，不会调用已配置的销毁生命周期回调（即prototype不会调用destroy方法）。客户端代码必须清理原型范围的对象并释放原型bean所拥有的昂贵资源。
要使Spring容器释放原型范围的bean所拥有的资源，请尝试使用自定义[bean后置处理器](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-extension-bpp)，它包含对需要清理的bean的引用。

在某些方面，Spring容器关于原型范围bean的角色是Java new运算符的替代品。超过该点的所有生命周期管理必须由客户端处理。 （有关Spring容器中bean的生命周期的详细信息，请参阅[Lifecycle Callbacks](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-lifecycle)。）

<h4 id="1.5.3">1.5.3 单例bean依赖原型bean</h4>
当您使用具有依赖于原型bean的单例作用域bean时，请注意在实例化时解析依赖项。因此，如果依赖项将原型范围的bean注入到单例范围的bean中，则会实例化一个新的原型bean，然后将依赖注入到单例bean中。原型实例是唯一提供给单例范围bean的实例

但是，假设您希望单例范围的bean在运行时重复获取原型范围的bean的新实例。您不能将原型范围的bean依赖注入到您的单例bean中，因为当Spring容器实例化单例bean并解析并注入其依赖项时，该注入只发生一次。
如果您需要在运行时多次使用原型bean的新实例，请参阅[方法注入](#1.4.6)。

<h4 id="1.5.4">1.5.4 请求，会话，应用程序和WebSocket范围</h4>
仅当您使用Web感知的Spring ApplicationContext实现（例如`XmlWebApplicationContext`）时，请求，会话，应用程序和websocket范围才可用。
如果将这些范围与常规的Spring IoC容器（例如`ClassPathXmlApplicationContext`）一起使用，则会引发未知bean范围的IllegalStateException。

##### Initial Web Configuration
要在请求，会话，应用程序和websocket级别（Web范围的bean）支持bean的范围，在定义bean之前需要一些小的初始配置。（标准范围不需要此初始设置：单例和原型。）

如何完成此初始设置取决于您的特定Servlet环境。

如果您在Spring Web MVC中访问scoped bean，实际上是在Spring `DispatcherServlet`处理的请求中，则无需进行特殊设置。 `DispatcherServlet`已经公开了所有相关状态。

如果您使用Servlet 2.5 Web容器，请求在Spring的`DispatcherServlet`之外处理（例如，使用JSF或Struts时），您需要注册`org.springframework.web.context.request.RequestContextListener ServletRequestListener`。
对于Servlet 3.0+，可以使用WebApplicationInitializer接口以编程方式完成此操作。或者对于旧容器，将以下声明添加到Web应用程序的`web.xml`文件中：
```
<web-app>
    ...
    <listener>
        <listener-class>
            org.springframework.web.context.request.RequestContextListener
        </listener-class>
    </listener>
    ...
</web-app>
```
或者，如果您的侦听器设置存在问题，请考虑使用Spring的`RequestContextFilter`。过滤器映射取决于周围的Web应用程序配置，因此您必须根据需要进行更改。以下清单显示了Web应用程序的过滤器部分：
```
<web-app>
    ...
    <filter>
        <filter-name>requestContextFilter</filter-name>
        <filter-class>org.springframework.web.filter.RequestContextFilter</filter-class>
    </filter>
    <filter-mapping>
        <filter-name>requestContextFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>
    ...
</web-app>
```
`DispatcherServlet`，`RequestContextListener`和`RequestContextFilter`做的事完全相同，即将HTTP请求对象绑定到为该请求提供服务的Thread。这使得请求和会话范围的bean可以在调用链的下游进一步使用。

##### Request scope
考虑bean定义的以下XML配置：
```
<bean id="loginAction" class="com.something.LoginAction" scope="request"/>
```
Spring容器通过对每个HTTP请求使用loginAction bean definition来创建LoginAction bean的新实例。也就是说，loginAction bean的范围是HTTP请求级别。您可以根据需要更改创建的实例的内部状态。它们特别针对个人要求。
当请求完成处理时，将放弃作用于请求的bean。

使用注释驱动的组件或Java配置时，可以使用@RequestScope注释将组件分配给请求范围。以下示例显示了如何执行此操作：
```
@RequestScope
@Component
public class LoginAction {
    // ...
}
```

##### Session Scope
考虑bean定义的以下XML配置：
```
<bean id="userPreferences" class="com.something.UserPreferences" scope="session"/>
```
Spring容器通过在单个HTTP会话的生存期内使用`userPreferences` bean definition来创建`UserPreferences` bean的新实例。换句话说，userPreferences bean在HTTP会话级别有效地作用域。
与request scope的bean一样，您可以根据需要更改创建的实例的内部状态，因为同样使用从同一userPreferences bean定义创建的实例的其他HTTP Session实例也不会在状态中看到这些更改，因为它们特定于单个HTTP会话。
丢弃HTTP会话时，也会丢弃作用于该特定HTTP会话的bean。

使用注释驱动的组件或Java配置时，可以使用@SessionScope批注将组件分配给会话范围。
```
@SessionScope
@Component
public class UserPreferences {
    // ...
}
```

##### Application Scope
考虑bean定义的以下XML配置：
```
<bean id="appPreferences" class="com.something.AppPreferences" scope="application"/>
```
Spring容器通过对整个Web应用程序使用`appPreferences` bean定义一次来创建AppPreferences bean的新实例。也就是说，`appPreferences` bean的作用域是`ServletContext`级别，并存储为常规的ServletContext属性。
这有点类似于Spring单例bean，但在两个重要方面有所不同:
* 它是每个ServletContext的单例，而不是每个Spring的'ApplicationContext'（在任何给定的Web应用程序中可能有几个）
* 它实际上是公开的，因此可以看作ServletContext属性

使用注释驱动的组件或Java配置时，可以使用@ApplicationScope批注将组件分配给应用程序范围。以下示例显示了如何执行此操作：
```
@ApplicationScope
@Component
public class AppPreferences {
    // ...
}
```
##### 作为依赖关系的Scoped Bean (Scoped Beans as Dependencies)
Spring IoC容器不仅管理对象（bean）的实例化，还管理协作者（或依赖关系）的连接。如果要将（例如）HTTP request范围的bean注入到寿命较长范围的另一个bean中，您可以选择注入AOP代理来代替范围内的bean。
也就是说，您需要注入一个代理对象，该对象公开与范围对象相同的公共接口，但也可以从相关范围中检索真实目标对象。

> 您还可以在作为单例的作用域的bean之间使用`<aop：scoped-proxy />`，然后引用通过可序列化的中间代理，从而能够在反序列化时重新获取目标单例bean。
> 
> 当针对范围原型的bean声明`<aop：scoped-proxy />`时，共享代理上的每个方法调用都会导致创建一个新的目标实例，然后将该调用转发到该目标实例。
> 
> 此外，范围代理不是以生命周期安全的方式从较短范围访问bean的唯一方法。您还可以将您的注入点（即构造函数或setter参数或自动装配字段）声明为ObjectFactory <MyTargetBean>，允许getObject（）
调用在每次需要时按需检索当前实例 - 而不必保留实例或单独存储它。
>
> 作为扩展变体，您可以声明ObjectProvider <MyTargetBean>，它提供了几个额外的访问变体，包括getIfAvailable和getIfUnique。
>
> JSR-330的变体称为Provider，与每个检索尝试的Provider <MyTargetBean>声明和相应的get（）调用一起使用。有关JSR-330整体的更多详细信息，请参见[此处](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-standard-annotations)。

以下示例中的配置只有一行，但了解“为什么”以及它背后的“如何”非常重要：
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:aop="http://www.springframework.org/schema/aop"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/aop
        https://www.springframework.org/schema/aop/spring-aop.xsd">

    <!-- an HTTP Session-scoped bean exposed as a proxy -->
    <bean id="userPreferences" class="com.something.UserPreferences" scope="session">
        <!-- instructs the container to proxy the surrounding bean -->
        <aop:scoped-proxy/>  // The line that defines the proxy.
    </bean>

    <!-- a singleton-scoped bean injected with a proxy to the above bean -->
    <bean id="userService" class="com.something.SimpleUserService">
        <!-- a reference to the proxied userPreferences bean -->
        <property name="userPreferences" ref="userPreferences"/>
    </bean>
</beans>
```
要创建此类代理，请将子`<aop：scoped-proxy />`元素插入到作用域bean定义中 (see[ Choosing the Type of Proxy to Create](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-scopes-other-injection-proxies) 
and [XML Schema-based configuration](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#xsd-schemas)).
为什么在请求，会话和自定义范围级别定义bean的定义需要`<aop：scoped-proxy />`元素？考虑以下单例bean定义，并将其与您需要为上述范围定义的内容进行对比（请注意，以下userPreferences bean定义不完整）：
```
<bean id="userPreferences" class="com.something.UserPreferences" scope="session"/>

<bean id="userManager" class="com.something.UserManager">
    <property name="userPreferences" ref="userPreferences"/>
</bean>
```
在前面的示例中，单例bean（userManager）注入了对HTTP会话范围的bean（userPreferences）的引用。这里的重点是userManager bean是一个单例：
这里的重点是userManager bean是一个单例：它每个容器只实例化一次，它的依赖项（在这种情况下只有一个，userPreferences bean）也只注入一次。
这意味着userManager bean仅在完全相同的userPreferences对象（即最初注入它的对象）上运行。

当将生命周期较短的scoped bean注入一个寿命较长的scoped bean时，这不是你想要的行为(例如，将HTTP会话范围的协作bean作为依赖项注入到singleton bean中）。
相反，您需要一个`userManager`对象，并且，对于HTTP会话的生命周期，您需要一个特定于HTTP会话的`userPreferences`对象。
因此，容器创建一个对象，该对象公开与UserPreferences类（理想情况下是`UserPreferences`实例的对象）完全相同的公共接口，该对象可以从作用域机制（HTTP请求，会话等）获取真实的`UserPreferences`对象。
容器将此代理对象注入`userManager` bean，该bean不知道此`UserPreferences`引用是代理。在此示例中，当UserManager实例在依赖注入的`UserPreferences`对象上调用方法时，它实际上是在代理上调用方法。
然后，代理从（在这种情况下）HTTP会话中获取真实的`UserPreferences`对象，并将方法调用委托给检索到的真实`UserPreferences`对象。

因此，在将请求和会话范围的bean注入协作对象时，您需要以下（正确和完整）配置，如以下示例所示：
```
<bean id="userPreferences" class="com.something.UserPreferences" scope="session">
    <aop:scoped-proxy/>
</bean>

<bean id="userManager" class="com.something.UserManager">
    <property name="userPreferences" ref="userPreferences"/>
</bean>
```
##### Choosing the Type of Proxy to Create
默认情况下，当Spring容器为使用`<aop：scoped-proxy />`元素标记的bean创建代理时，将创建基于CGLIB的类代理。
> CGLIB代理只拦截公共方法调用！不要在这样的代理上调用非公共方法。它们不会委托给实际的作用域目标对象。

或者，您可以通过为`<aop：scoped-proxy />`元素的proxy-target-class属性的值指定false，将Spring容器配置为为此类作用域bean创建基于JDK接口的标准代理。
使用基于JDK接口的代理意味着您不需要在应用程序类路径中使用其他库来影响此类代理。
但是，这也意味着作用域bean的类必须至少实现一个接口，并且注入了作用域bean的所有协作者必须通过其中一个接口引用bean。以下示例显示了基于接口的代理：
```
<!-- DefaultUserPreferences implements the UserPreferences interface -->
<bean id="userPreferences" class="com.stuff.DefaultUserPreferences" scope="session">
    <aop:scoped-proxy proxy-target-class="false"/>
</bean>

<bean id="userManager" class="com.stuff.UserManager">
    <property name="userPreferences" ref="userPreferences"/>
</bean>
```
有关选择基于类或基于接口的代理的更多详细信息，请参阅[代理机制](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#aop-proxying)。

#### 1.5.5 自定义范围
bean范围机制是可扩展的。您可以定义自己的范围，甚至可以重新定义现有范围，尽管后者被认为是不好的做法，您无法覆盖内置的单例和原型范围。

##### 创建自定义范围
要将自定义作用域集成到Spring容器中，需要实现org.springframework.beans.factory.config.Scope接口，本节将对此进行介绍。
有关如何实现自己的作用域的想法，请参阅Spring Framework本身和[`Scope`](https://docs.spring.io/spring-framework/docs/5.1.6.RELEASE/javadoc-api/org/springframework/beans/factory/config/Scope.html) javadoc提供的Scope实现，它解释了您需要更详细地实现的方法。

Scope接口有四种方法可以从作用域中获取对象，从作用域中删除它们，然后将它们销毁。

例如，会话范围实现返回会话范围的bean（如果它不存在，则该方法在将其绑定到会话以供将来参考之后返回该bean的新实例）。以下方法从基础范围返回对象：
```
Object get(String name, ObjectFactory objectFactory)
```

例如，会话范围实现从基础会话中删除会话范围的bean。应返回该对象，但如果找不到具有指定名称的对象，则可以返回null。以下方法从基础范围中删除对象：
```
Object remove(String name)
```

以下方法记录范围在销毁时或范围中指定对象被销毁时应执行的回调：
```
void registerDestructionCallback(String name, Runnable destructionCallback)
```
有关销毁回调的更多信息，请参阅javadoc或Spring作用域实现。

以下方法获取基础范围的对话标识符：
```
String getConversationId()
```
每个范围的标识符都不同。对于会话范围的实现，该标识符可以是会话标识符。

##### 使用自定义范围
在编写并测试一个或多个自定义Scope实现之后，您需要让Spring容器知道您的新范围。以下方法是使用Spring容器注册新Scope的核心方法：
```
void registerScope(String scopeName, Scope scope);
```
此方法在ConfigurableBeanFactory接口上声明，该接口可通过Spring随附的大多数具体ApplicationContext实现上的BeanFactory属性获得。

registerScope（..）方法的第一个参数是与范围关联的唯一名称。Spring容器本身中的这些名称的示例是singleton和prototype。registerScope（..）方法的第二个参数是您希望注册和使用的自定义Scope实现的实际实例。

假设您编写自定义Scope实现，然后按照下一个示例中的说明进行注册。

> 下一个示例使用SimpleThreadScope，它包含在Spring中，但默认情况下未注册。对于您自己的自定义Scope实现，指令是相同的。

```
Scope threadScope = new SimpleThreadScope();
beanFactory.registerScope("thread", threadScope);
```

然后，您可以创建符合自定义Scope的作用域规则的bean定义，如下所示：
```
<bean id="..." class="..." scope="thread">
```

使用自定义Scope实现，您不仅限于范围的编程注册。您还可以使用CustomScopeConfigurer类以声明方式执行Scope注册，如以下示例所示：

```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:aop="http://www.springframework.org/schema/aop"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/aop
        https://www.springframework.org/schema/aop/spring-aop.xsd">

    <bean class="org.springframework.beans.factory.config.CustomScopeConfigurer">
        <property name="scopes">
            <map>
                <entry key="thread">
                    <bean class="org.springframework.context.support.SimpleThreadScope"/>
                </entry>
            </map>
        </property>
    </bean>

    <bean id="thing2" class="x.y.Thing2" scope="thread">
        <property name="name" value="Rick"/>
        <aop:scoped-proxy/>
    </bean>

    <bean id="thing1" class="x.y.Thing1">
        <property name="thing2" ref="thing2"/>
    </bean>

</beans>
```
当您在FactoryBean实现中放置`<aop：scoped-proxy />`时，它是作用域的工厂bean本身，而不是从getObject（）返回的对象。

### 1.6 定制Bean的本质
Spring Framework提供了许多可用于自定义bean特性的接口。本节将它们分组如下：
* Lifecycle Callbacks