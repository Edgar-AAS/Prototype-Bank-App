import XCTest
import Presentation

class WelcomeRouterTest: XCTestCase {
    func test_goToLogin_calls_nav_with_correct_vc() {
        let (sut, nav) = makeSut()
        sut.goToLogin()
        XCTAssertEqual(nav.viewControllers.count, 1)
        XCTAssertTrue(nav.viewControllers[0] is LoginViewController)
    }
    
    func test_goToRegister_calls_nav_with_correct_vc() {
        let (sut, nav) = makeSut()
        sut.goToSignUp()
        XCTAssertEqual(nav.viewControllers.count, 1)
        XCTAssertTrue(nav.viewControllers[0] is SignUpViewController)
    }
}

extension WelcomeRouterTest {
    func makeSut() -> (sut: WelcomeRouter, nav: NavigationController) {
        let nav = NavigationController()
        let loginFactorySpy = LoginFactorySpy()
        let signUpFactorySpy = SignUpFactorySpy()
        let sut = WelcomeRouter(nav: nav, loginFactory: loginFactorySpy.makeLogin, signUpFactory: signUpFactorySpy.makeSignUp)
        checkMemoryLeak(for: sut)
        return (sut, nav)
    }
}

extension WelcomeRouterTest {
    class LoginFactorySpy {
        func makeLogin() -> LoginViewController {
            return LoginViewController()
        }
    }
    
    class SignUpFactorySpy {
        func makeSignUp() -> SignUpViewController {
            return SignUpViewController()
        }
    }
}

