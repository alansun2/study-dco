 org.springframework.context.support.GenericApplicationContext 初始化了一个bean工厂 DefaultListableBeanFactory
    org.springframework.context.annotation.AnnotationConfigApplicationContext 初始化了AnnotatedBeanDefinitionReader ClassPathBeanDefinitionScanner
    AnnotatedBeanDefinitionReader是一个读取注解的Bean定义读取器
    1. 给bdmap中注册了六个spring的内部类
    ClassPathBeanDefinitionScanner是一个扫描器，扫描所有加了注解的bean







ImportBeanDefinitionRegistrar 注册
BeanFactoryPostProcessor 在bean被实例化之前操作bean，比如修改scope 无法添加


ConfigurationClassPostProcessor


FactoryBean BeanFactory

AbstractBeanFactory中获取bean -> doGetBean -> getObjectForBeanInstance 
该bean可能普通bean也可能是factoryBean（FactoryBean前面有`&`符号）

如果是FactoryBean通过FactoryBeanRegisterSupport的getObjectFromFactoryBean